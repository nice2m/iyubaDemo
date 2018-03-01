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
@property (nonatomic, weak) UIViewController *currentController;

@property (nonatomic, strong)NSMutableArray<BBCTitleModel *> * firstDataSource;
@property (nonatomic, strong)NSMutableArray<BBCTitleModel *> * secondDataSource;
@property (nonatomic, strong)NSMutableArray<BBCTitleModel *> * thirdDataSource;
@property (nonatomic, strong)NSMutableArray<BBCTitleModel *> * forthDataSource;


@end


@implementation HomeDataManager


//MARK: - interface

- (instancetype)initWith:(UIViewController *)currentController{
    if (self = [super init]){
        self.currentController = currentController;
    }
    return  self;
}

- (void)fetchDataWithParentID:(NSInteger)parentID completeHandler:(NetworkRequestCompleteHandler)completeHandler{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.currentController.view animated:true];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"加载中";
    [hud showAnimated:true];
    ;
    [[NetworkManager sharedManager] postUrl:kHomeDataApiWithParentID(parentID) parameter:@{} completeHandler:^(id responsObject, NSError *error) {
        NSLog(@"%@",responsObject);
        [hud hideAnimated:true];
        
        if (responsObject != nil) {
            [self parseXMLwithData:responsObject parentID:parentID];
        }
        else {
            MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.currentController.view animated:true];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"加载失败，请重试";
            [hud hideAnimated:true afterDelay:0.85];
        }
        completeHandler ? completeHandler(responsObject,error) : nil;
    }];
}

- (void)fetchData:(NetworkRequestCompleteHandler)completeHandler {
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.currentController.view animated:true];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"加载中";
    [hud showAnimated:true];
    ;
    [[NetworkManager sharedManager] postUrl:kHomeDataApiWithParentID((long)1) parameter:@{} completeHandler:^(id responsObject, NSError *error) {
        NSLog(@"%@",responsObject);
        [hud hideAnimated:true];
        
        if (responsObject != nil) {
            [self parseXMLwithData:responsObject parentID:(long)1];
        }
        else {
            MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.currentController.view animated:true];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"加载失败，请重试";
            [hud hideAnimated:true afterDelay:0.85];
        }
        completeHandler ? completeHandler(responsObject,error) : nil;
    }];
    
}

- (NSArray <NSString *>*)cycleImagesWithParentID:(NSInteger)parentID {
    NSArray * models = [self dataSourceWithParentId:parentID];
    
    NSMutableArray * rs = [NSMutableArray array];
    for (BBCTitleModel * model in models) {
        [rs addObject:model.Pic];
    }
    return rs;
}

//MARK: - private
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
