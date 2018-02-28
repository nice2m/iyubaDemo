//
//  HomeScrollPageView.m
//  iyubaDemo
//
//  Created by nice2meet on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import "HomeScrollPageView.h"


@interface HomeScrollPageView()

@property (nonatomic, strong) NSArray<NSString *> *imagesArray;
@property (nonatomic, copy) HomeScrollPageViewImgOnTapBlock imgOnTapBlock;

@end


@implementation HomeScrollPageView

- (instancetype)initWithFrame:(CGRect)frame imagesArray:(NSArray<NSString *> *)imagesArray imgOnTapBlock:(HomeScrollPageViewImgOnTapBlock)imgOnTapBlock{
    if (self = [super initWithFrame:frame]){
        self.imagesArray = imagesArray;
        self.imgOnTapBlock = imgOnTapBlock;
        [self configUI];
    }
    return self;
}

//MARK: - private

#warning "    // TODO: "

- (void)configUI {
    // TODO:
    
    // 配置 上一张，下一张 按钮显示
    
    // 配置cycleScrollView;
    
}

@end
