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
@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) SDCycleScrollView * cycleView;
@property (nonatomic, assign) NSInteger currentScrollPageIndex;

@end


@implementation HomeScrollPageView

- (instancetype)initWithFrame:(CGRect)frame imagesUrlArray:(NSArray<NSString *> *)imagesArray imgOnTapBlock:(HomeScrollPageViewImgOnTapBlock)imgOnTapBlock{
    if (self = [super initWithFrame:frame]){
        self.imagesArray = imagesArray;
        self.imgOnTapBlock = imgOnTapBlock;
        self.currentScrollPageIndex = 0;
        [self configUI];
    }
    return self;
}

- (void)updateImages:(NSArray<NSString *>*)images{
    [_cycleView clearCache];
    _cycleView.imageURLStringsGroup = images;
}


//MARK: - private

- (void)configUI {
    // 配置 上一张，下一张 按钮显示
    // 配置cycleScrollView;
    // 上一张，下一张，pageViewControl
    
    _containerView = [[UIView alloc] init];
    [self addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"homeScrollPagePlaceHolder"]];
    [_containerView addSubview: _cycleView];
    [_cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_containerView);
    }];
    
    __weak typeof(self) weakSelf = self;
    
    _cycleView.itemDidScrollOperationBlock = ^(NSInteger currentIndex) {
        NSLog(@"itemDidScrollOperationBlock: \t%ld",currentIndex);
        weakSelf.currentScrollPageIndex = currentIndex;
    };
    
    // left
    // left-arrow
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"left-arrow"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:leftBtn];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"right-arrow"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:rightBtn];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_containerView);
        make.leading.equalTo(_containerView.mas_leading).offset(8.0);
        make.height.equalTo(@32.0);
        make.width.equalTo(@32.0);
    }];
    
    // right
    // right-arrow
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_containerView);
        make.trailing.equalTo(_containerView.mas_trailing).offset(-8.0);
        make.height.equalTo(@32.0);
        make.width.equalTo(@32.0);
    }];
}


//MARK: - event

- (void)leftBtnPressed:(UIButton *)sender {
    NSInteger lastIndex = self.currentScrollPageIndex - 1;
    
    if (self.currentScrollPageIndex <= 0){
        lastIndex = self.imagesArray.count - 1;
    }
    [_cycleView makeScrollViewScrollToIndex:lastIndex];
}

- (void)rightBtnPressed:(UIButton *)sender{
    NSInteger nextIndex = self.currentScrollPageIndex + 1;
    if (self.currentScrollPageIndex >= (self.imagesArray.count - 1)){
        nextIndex = 0 ;
    }
    [_cycleView makeScrollViewScrollToIndex:nextIndex];
}

@end




@implementation HomeScrollPageView(delegate)

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index:%ld",(long)index);
    
    self.imgOnTapBlock ? self.imgOnTapBlock(index) : nil;

}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    NSLog(@"cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index:%ld",(long)index);
}

@end


