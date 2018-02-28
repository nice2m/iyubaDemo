//
//  HomeDataManager.h
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BBCTitleModel;

@interface HomeDataManager : NSObject

@property(nonatomic, strong) NSMutableArray<BBCTitleModel*> *dataSource;

- (void)fetchNextPage;

@end
