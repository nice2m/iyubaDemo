//
//  HomeDataManager.h
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"

@class BBCTitleModel;

@interface HomeDataManager : NSObject

- (instancetype)initWith:(UIViewController *)currentController;


- (void)fetchData:(NetworkRequestCompleteHandler)completeHandler;

- (void)fetchDataWithParentID:(NSInteger)parentID completeHandler:(NetworkRequestCompleteHandler)completeHandler;
- (NSArray<BBCTitleModel *> *)dataSourceWithParentId:(NSInteger)parentID;
- (NSArray <NSString *>*)cycleImagesWithParentID:(NSInteger)parentID;

@end
