//
//  HomeFooterView.m
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/3/1.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import "HomeFooterView.h"



@interface HomeFooterView()

@property (nonatomic, copy)HomeFooterViewBtnPressedBlock lastBtnBlock;
@property (nonatomic, copy)HomeFooterViewBtnPressedBlock nextBtnBlock;
@property (nonatomic, copy)HomeFooterViewBtnPressedBlock bottomImgBlock;

@property (nonatomic, strong) UIView * topContainerView;
@property (nonatomic, strong) UIView * bottomContainerView;

@end

@implementation HomeFooterView


//MARK: - interface

- (instancetype)initWithFrame:(CGRect)frame lastBtnBlock:(HomeFooterViewBtnPressedBlock)lastBtnBlock nextBtnBlock:(HomeFooterViewBtnPressedBlock)nextBtnBlock bottomImgBlock:(HomeFooterViewBtnPressedBlock)bottomImgBlock{
    if (self = [super initWithFrame:frame]){
        self.lastBtnBlock = lastBtnBlock;
        self.nextBtnBlock = nextBtnBlock;
        self.bottomImgBlock = bottomImgBlock;
        
        [self configUI];
    }
    return  self;
    
}

//MARK: - private
- (void)configUI{
    _topContainerView = [UIView new];
    _topContainerView.backgroundColor = [UIColor colorWithHexString:@"#159867"];
    [self addSubview:_topContainerView];
    
    _bottomContainerView = [UIView new];
    [self addSubview: _bottomContainerView];
    [_topContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self);
        make.height.equalTo(@32.0);
    }];
    
    [_bottomContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.top.equalTo(_topContainerView.mas_bottom);
    }];
    
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    [leftBtn setTitle:@"上一页" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnPressed:) forControlEvents:UIControlEventTouchUpInside];

    [_topContainerView addSubview:leftBtn];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"下一页" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_topContainerView addSubview:rightBtn];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.equalTo(_topContainerView);
        make.trailing.equalTo(rightBtn.mas_leading);
        make.width.equalTo(rightBtn);

    }];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.bottom.equalTo(_topContainerView);
        make.leading.equalTo(leftBtn.mas_trailing);
        make.width.equalTo(leftBtn);
    }];
    
    
    //底部视图
    UIImageView * bottomImageView = [[UIImageView alloc] init];
    bottomImageView.image = [UIImage imageNamed:@"bottomImg"];
    bottomImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.bottomContainerView addSubview:bottomImageView];
    
    bottomImageView.userInteractionEnabled = YES;
    [bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomContainerView);
    }];
    
    UITapGestureRecognizer * tapGS = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomImgOnTap:)];
    [bottomImageView addGestureRecognizer:tapGS];
    
    
}

#pragma mark - event
- (void)leftBtnPressed:(UIButton *)sender {
    self.lastBtnBlock ? self.lastBtnBlock() : nil;
}

- (void)rightBtnPressed:(UIButton *)sender{
    self.nextBtnBlock ? self.nextBtnBlock() : nil;
}

- (void)bottomImgOnTap:(UITapGestureRecognizer *)sender{
    self.bottomImgBlock ? self.bottomImgBlock() : nil;
}



@end
