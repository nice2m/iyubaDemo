//
//  UIViewController+toast.m
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/3/1.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import "UIViewController+toast.h"
#import <objc/runtime.h>


static NSTimeInterval const kToastAnimationDuration = 0.75;
static const char * kEx_HUDKey = "kEx_HUDKey";


@implementation UIViewController (toast)


#pragma mark -


- (void)ex_showToast:(NSString *)text{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    hud.label.text = text;
    hud.mode = MBProgressHUDModeText;
    
    [hud hideAnimated:true afterDelay:kToastAnimationDuration];
}

- (void)ex_showHud:(NSString *)text{
    self.ex_HUD.mode = MBProgressHUDModeIndeterminate;
    self.ex_HUD.label.text = text;
    [self.ex_HUD showAnimated:true];
}


- (void)ex_hideHud{
    [self.ex_HUD hideAnimated:true];
}

#pragma mark - private

- (void)setEx_HUD:(MBProgressHUD *)ex_HUD{
    objc_setAssociatedObject(self, kEx_HUDKey, ex_HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (MBProgressHUD *)ex_HUD{
    MBProgressHUD * hud = objc_getAssociatedObject(self, kEx_HUDKey);
    
    if (hud == nil){
        hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        self.ex_HUD = hud;
    }
    
    return hud;
}


@end
