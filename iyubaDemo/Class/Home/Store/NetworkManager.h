//
//  NetworkManager.h
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Api.h"



typedef void(^NetworkRequestCompleteHandler)(id responsObject,NSError * error);

@interface NetworkManager : NSObject

+ (instancetype)sharedManager;

- (void)postUrl:(NSString *)url parameter:(NSDictionary *)param completeHandler:(NetworkRequestCompleteHandler)complete;


@end
