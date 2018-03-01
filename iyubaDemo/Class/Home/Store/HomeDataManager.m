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


@end


@implementation HomeDataManager


//MARK: - interface

- (instancetype)initWith:(UIViewController *)currentController{
    if (self = [super init]){
        self.currentController = currentController;
    }
    return  self;
}

- (void)fetchData:(NetworkRequestCompleteHandler)completeHandler {
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.currentController.view animated:true];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"加载中";
    [hud showAnimated:true];
    [[NetworkManager sharedManager] postUrl:@"http://apps.iyuba.com/minutes/titleNewApi.jsp?maxid=0&format=xml&type=android" parameter:@{} completeHandler:^(id responsObject, NSError *error) {
        NSLog(@"%@",responsObject);
        [hud hideAnimated:true];
        
        if (responsObject != nil) {
            [self parseXMLwithData:responsObject];
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

- (NSArray <NSString *>*)cycleImages {
    NSMutableArray * rs = [NSMutableArray array];
    for (BBCTitleModel * model in self.dataSource) {
        [rs addObject:model.Pic];
    }
    return rs;
}

//MARK: - private
- (void) parseXMLwithData:(NSData *)data{
    NSError * documentError = nil;
    ONOXMLDocument * document = [ONOXMLDocument XMLDocumentWithData:data error:&documentError];
    if (documentError) {
        NSLog(@"%@",documentError);
        return;
    }
    [self.dataSource removeAllObjects];
    
    [document.rootElement enumerateElementsWithXPath:@"Bbctitle" usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
        // NSLog(@"%@",element);
        NSMutableDictionary * modelDict = [NSMutableDictionary dictionary];
        for (ONOXMLElement * tmpElement in element.children) {
            NSLog(@"%@",tmpElement.tag);
            modelDict[tmpElement.tag] = tmpElement.stringValue;
        }
        BBCTitleModel * model = [BBCTitleModel yy_modelWithDictionary:modelDict];
        [self.dataSource addObject:model];
    }];
    
}

- (NSMutableArray<BBCTitleModel *> *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


@end
