//
//  HomeTopView.m
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//
#import <Masonry/Masonry.h>

#import "HomeTopViewCollectionTabCellModel.h"

#import "HomeTopView.h"
#import "HomeTopViewCollectionTabCell.h"


static NSString * kHomeTopViewTabcellReuseID = @"HomeTopViewCollectionTabCell";
CGFloat kHomeTopViewCellSpacing = 8.0;

@interface HomeTopView()

@property (nonatomic, copy) HomeTopTabCellPressed tabCellPressed;
@property (nonatomic, copy) HomeTopViewHomeBtnPressed homeBtnPressed;
@property (nonatomic, strong) UIImageView * topImgView;
@property (nonatomic, strong) UIButton * homeBtn;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UIView * lineJumpView;

@property (nonatomic, copy) NSMutableArray<HomeTopViewCollectionTabCellModel *> *tabTitleModels;
@property (nonatomic, strong) UIImage * topBgImg;
@property (nonatomic, assign) CGSize tabCellSize;

@end

@implementation HomeTopView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *>*)titles topBgImg:(UIImage *)topBgImg tabCellSize:(CGSize)tabCellSize homeBtnPressed:(HomeTopViewHomeBtnPressed)homeBtnPressed tabCellPressed:(HomeTopTabCellPressed)tabCellPressed{
    if (self = [super initWithFrame: frame]) {
        
        self.topBgImg = topBgImg;
        self.tabCellPressed = tabCellPressed;
        self.homeBtnPressed = homeBtnPressed;
        self.tabCellSize = tabCellSize;
        
        for (NSString * title in titles) {
             NSDictionary * tmpDict = @{@"title":title,@"isSelected":@false};
            HomeTopViewCollectionTabCellModel * model = [HomeTopViewCollectionTabCellModel yy_modelWithDictionary:tmpDict];
            [self.tabTitleModels addObject:model];
        }
        
        [self configUI];
    }
    return self;
}


- (void)updateJumpLineTo:(NSInteger)index{
    
    //
    for (HomeTopViewCollectionTabCellModel * cellModel in self.tabTitleModels) {
        cellModel.isSelected = false;
    }
    self.tabTitleModels[index].isSelected = true;
    [self.collectionView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collectionView bringSubviewToFront:self.lineJumpView];
    });
    
    CGSize nowSize = self.lineJumpView.frame.size;
    CGFloat newOriginX = index * self.tabCellSize.width ;
    if (index >= 1){
        newOriginX += index * kHomeTopViewCellSpacing;
    }
    
    [UIView animateWithDuration:0.15 animations:^{
        self.lineJumpView.frame = CGRectMake(newOriginX, 42.0, nowSize.width, nowSize.height);
    }];
}

#pragma mark  - event
- (void)homeBtnPressedAction:(UIButton *)sender{
    NSLog(@"%@",sender);
    self.homeBtnPressed ? self.homeBtnPressed() : nil;
}

#pragma mark - private

- (void)configUI {
    UIView * topContainerView = [[UIView alloc] init];
    UIView * bottomContainerView = [[UIView alloc] init];
    [topContainerView setBackgroundColor:[UIColor colorWithHexString:@"#159867"]];
    
    [self addSubview:topContainerView];
    [self addSubview:bottomContainerView];
    
    [topContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self);
        make.height.equalTo(@44.0);
    }];
    
    [bottomContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.equalTo(topContainerView.mas_bottom);
        make.height.equalTo(@44.0);
    }];
    
    // 顶部视图
    _topImgView = [[UIImageView alloc] init];
    _topImgView.image = self.topBgImg;
    _topImgView.contentMode = UIViewContentModeLeft;
    _topImgView.clipsToBounds  = YES;
    
    [topContainerView addSubview:_topImgView];
    
    _homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_homeBtn setImage:[UIImage imageNamed:@"homeIndexBtn"] forState:UIControlStateNormal];
    [_homeBtn addTarget:self action:@selector(homeBtnPressedAction:) forControlEvents:UIControlEventTouchUpInside];
    _homeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;

    [topContainerView addSubview:_homeBtn];
    
    [_topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(topContainerView).offset(8.0);
        make.bottom.equalTo(topContainerView).offset(-8.0);
        make.width.equalTo(@192.0);
    }];
    [_homeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(topContainerView.mas_trailing).offset(-8.0);
        make.top.equalTo(topContainerView).offset(8.0);
        make.bottom.equalTo(topContainerView).offset(-8.0);
        make.width.equalTo(@44.0);
    }];
    
    //布局底部视图
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = self.tabCellSize;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = kHomeTopViewCellSpacing;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView setContentOffset:CGPointMake(0, -2)];
    [bottomContainerView addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bottomContainerView);
    }];
    UINib * cellNib = [UINib nibWithNibName:kHomeTopViewTabcellReuseID bundle:nil];
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:kHomeTopViewTabcellReuseID];
    
    
    // 布局底部跳动视图,直接添加在!!trickey:!!!CollectionView 中
    _lineJumpView = [[UIView alloc] init];
    _lineJumpView.backgroundColor = [UIColor redColor];
    [_collectionView addSubview:_lineJumpView];
    
    _lineJumpView.frame = CGRectMake(0, 42, self.tabCellSize.width, 2.0);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collectionView bringSubviewToFront:(_lineJumpView)];
    });
    [self updateJumpLineTo:0];
}

- (NSMutableArray<HomeTopViewCollectionTabCellModel *> *)tabTitleModels {
    if (_tabTitleModels == nil) {
        _tabTitleModels = [NSMutableArray array];
    }
    return _tabTitleModels;
}

@end

#pragma mark - UICollectionViewDelegate

@implementation HomeTopView(HomeTopView_extension)

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.tabCellPressed ? self.tabCellPressed(indexPath.row) : nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.tabTitleModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeTopViewCollectionTabCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeTopViewTabcellReuseID forIndexPath:indexPath];
    [cell configModel:self.tabTitleModels[indexPath.row]];
    return  cell;
}

@end

