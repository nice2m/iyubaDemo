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

- (instancetype)initWithFrame:(CGRect)frame imagesUrlArray:(NSArray<NSString *>*)imagesArray imgOnTapBlock:(HomeScrollPageViewImgOnTapBlock)imgOnTapBlock;
- (void)updateImages:(NSArray<NSString *>*)images;

@end

@interface HomeScrollPageView(delegate)<SDCycleScrollViewDelegate>

@end
