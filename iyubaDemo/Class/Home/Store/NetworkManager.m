//
//  NetworkManager.m
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>


@interface NetworkManager()

@property (nonatomic, strong) AFNetworkReachabilityManager * reachabilityManager;
@property (nonatomic, strong) AFHTTPSessionManager * sessionManager;

@end


@implementation NetworkManager

+ (instancetype)sharedManager {
    static NetworkManager * _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
        [_manager configManager];
        
    });
    return _manager;
}

//MARK: - event

//MARK: - private

- (void)configManager {
    
    _reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [_reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%ld",(long)status);
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"无数据链接");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"有链接");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"wwan");
                break;
            default:
                break;
        }
    }];
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
}

//MARK: - interface

-(void)postUrl:(NSString *)url parameter:(NSDictionary *)param completeHandler:(NetworkRequestCompleteHandler)complete{
    [_sessionManager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed");
        complete(nil,error);
    }];
}

@end


