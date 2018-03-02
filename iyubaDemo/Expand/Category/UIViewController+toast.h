//
//  UIViewController+toast.h
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/3/1.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>


@interface UIViewController (toast)

@property (nonatomic, strong) MBProgressHUD * ex_HUD;


- (void)ex_showToast:(NSString *)text;

- (void)ex_showHud:(NSString *)text;
- (void)ex_hideHud;

@end
