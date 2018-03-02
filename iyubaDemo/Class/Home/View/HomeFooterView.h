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


/**
 初始化 Home Footer 控件

 @param frame 该控件的frame
 @param lastBtnBlock 上一页点击回调
 @param nextBtnBlock 下一页点击回调
 @param bottomImgBlock 底部图片按钮点击回调
 @return “”
 */
- (instancetype)initWithFrame:(CGRect)frame lastBtnBlock:(HomeFooterViewBtnPressedBlock)lastBtnBlock nextBtnBlock:(HomeFooterViewBtnPressedBlock)nextBtnBlock bottomImgBlock:(HomeFooterViewBtnPressedBlock)bottomImgBlock;

@end
