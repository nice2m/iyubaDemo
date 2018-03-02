//
//  HomeScrollPageView.h
//  iyubaDemo
//
//  Created by nice2meet on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>

typedef void(^HomeScrollPageViewImgOnTapBlock)(NSInteger index);

@interface HomeScrollPageView : UIView


/**
 初始化Home scrollPage 控件；

 @param frame 该控件的frame
 @param imagesArray 该控件的图片Url 数组
 @param imgOnTapBlock 图片点击回调
 @return “”
 */
- (instancetype)initWithFrame:(CGRect)frame imagesUrlArray:(NSArray<NSString *>*)imagesArray imgOnTapBlock:(HomeScrollPageViewImgOnTapBlock)imgOnTapBlock;
- (void)updateImages:(NSArray<NSString *>*)images;

@end

@interface HomeScrollPageView(delegate)<SDCycleScrollViewDelegate>

@end
