//
//  UIViewController+toast.m
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/3/1.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import "UIViewController+toast.h"

@implementation UIViewController (toast)

- (void)showToast:(NSString *)text{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    hud.label.text = text;
    hud.mode = MBProgressHUDModeText;
    
    [hud hideAnimated:true afterDelay:0.75];
    
}
@end
