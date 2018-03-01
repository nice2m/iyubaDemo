//
//  HomeFooterView.h
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/3/1.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^HomeFooterViewBtnPressedBlock)(void);
@interface HomeFooterView : UIView


- (instancetype)initWithFrame:(CGRect)frame lastBtnBlock:(HomeFooterViewBtnPressedBlock)lastBtnBlock nextBtnBlock:(HomeFooterViewBtnPressedBlock)nextBtnBlock bottomImgBlock:(HomeFooterViewBtnPressedBlock)bottomImgBlock;

@end
