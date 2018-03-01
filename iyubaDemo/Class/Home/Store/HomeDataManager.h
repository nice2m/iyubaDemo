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

@property(nonatomic, strong) NSMutableArray<BBCTitleModel*> *dataSource;


- (instancetype)initWith:(UIViewController *)currentController;


- (void)fetchData:(NetworkRequestCompleteHandler)completeHandler;

- (NSArray <NSString *>*)cycleImages;

@end
