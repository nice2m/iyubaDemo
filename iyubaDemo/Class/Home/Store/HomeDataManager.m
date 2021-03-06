//
//  HomeDataManager.m
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//
#import <Ono.h>

#import "HomeDataManager.h"
#import "BBCTitleModel.h"


@interface HomeDataManager()

@property (nonatomic, assign) NSInteger currentPageNo;

@property (nonatomic, strong)NSMutableArray<BBCTitleModel *> * firstDataSource;
@property (nonatomic, strong)NSMutableArray<BBCTitleModel *> * secondDataSource;
@property (nonatomic, strong)NSMutableArray<BBCTitleModel *> * thirdDataSource;
@property (nonatomic, strong)NSMutableArray<BBCTitleModel *> * forthDataSource;


@end


@implementation HomeDataManager


#pragma mark - interface

- (instancetype)init{
    if (self = [super init]){
    }
    return  self;
}

- (void)fetchDataWithParentID:(NSInteger)parentID completeHandler:(NetworkRequestCompleteHandler)completeHandler{
    [[NetworkManager sharedManager] postUrl:kHomeDataApiWithParentID(parentID) parameter:@{} completeHandler:^(id responsObject, NSError *error) {
        NSLog(@"%@\t%@",responsObject,error);
        
        if (responsObject != nil) {
            [self parseXMLwithData:responsObject parentID:parentID];
        }
        completeHandler ? completeHandler(responsObject,error) : nil;
    }];
}


- (NSArray <NSString *>*)cycleImagesWithParentID:(NSInteger)parentID {
    NSArray * models = [self dataSourceWithParentId:parentID];
    
    NSMutableArray * rs = [NSMutableArray array];
    for (BBCTitleModel * model in models) {
        [rs addObject:model.pic];
    }
    return rs;
}

#pragma mark - private
- (void) parseXMLwithData:(NSData *)data parentID:(NSInteger)parentID{
    
    NSMutableArray * rsArr = nil;
    switch (parentID) {
        case 1:
            rsArr = self.firstDataSource;
            break;
        case 2:
            rsArr = self.secondDataSource;
            break;
        case 3:
            rsArr = self.thirdDataSource;
            break;
        default:
            rsArr = self.forthDataSource;
            break;
    }
    
    
    NSError * documentError = nil;
    ONOXMLDocument * document = [ONOXMLDocument XMLDocumentWithData:data error:&documentError];
    if (documentError) {
        NSLog(@"%@",documentError);
        return;
    }
    [rsArr removeAllObjects];
    
    [document.rootElement enumerateElementsWithXPath:@"Bbctitle" usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
        // NSLog(@"%@",element);
        NSMutableDictionary * modelDict = [NSMutableDictionary dictionary];
        for (ONOXMLElement * tmpElement in element.children) {
            NSLog(@"%@",tmpElement.tag);
            modelDict[tmpElement.tag] = tmpElement.stringValue;
        }
        BBCTitleModel * model = [BBCTitleModel yy_modelWithDictionary:modelDict];
        [rsArr addObject:model];
    }];
}

- (NSArray<BBCTitleModel *> *)dataSourceWithParentId:(NSInteger)parentID{
    switch (parentID) {
        case 1:
            return  [self.firstDataSource copy];
            break;
        case 2:
            return  [self.secondDataSource copy];
            break;
        case 3:
            return  [self.thirdDataSource copy];
            break;
            
        default:
            return  [self.forthDataSource copy];

            break;
    }
}


#pragma mark - lazy load

- (NSMutableArray<BBCTitleModel *> *)firstDataSource{
    if (_firstDataSource == nil){
        _firstDataSource = [NSMutableArray array];
    }
    return _firstDataSource;
}

- (NSMutableArray<BBCTitleModel *> *)secondDataSource{
    if (_secondDataSource == nil){
        _secondDataSource = [NSMutableArray array];
    }
    return _secondDataSource;
}
- (NSMutableArray<BBCTitleModel *> *)thirdDataSource{
    if (_thirdDataSource == nil){
        _thirdDataSource = [NSMutableArray array];
    }
    return _thirdDataSource;
}
- (NSMutableArray<BBCTitleModel *> *)forthDataSource{
    if (_forthDataSource == nil){
        _forthDataSource = [NSMutableArray array];
    }
    return _forthDataSource;
}




@end
