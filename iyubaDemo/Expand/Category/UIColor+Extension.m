//
//  UIColor+Extension.m
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/3/1.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (instancetype)colorWithHexString:(NSString *)hexString{
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    return [self colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0f green:((rgbValue & 0xFF00) >> 8)/255.0f blue:(rgbValue & 0xFF)/255.0f alpha:1.0];
}
@end
