//
//  HomeTopView.h
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HomeTopViewHomeBtnPressed)(void);
typedef void(^HomeTopTabCellPressed)(NSInteger tapIndex);

extern CGFloat kHomeTopViewCellSpacing;

@interface HomeTopView : UIView



/**
 初始化Home topView

 @param frame 该view 的frame
 @param titles 标题数组
 @param topBgImg 顶部视图左侧 logo 图片
 @param tabCellSize 标题size
 @param homeBtnPressed 顶部视图 home 按钮点击回调
 @param tabCellPressed 标题点击回调
 @return ""
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *>*)titles topBgImg:(UIImage *)topBgImg tabCellSize:(CGSize)tabCellSize homeBtnPressed:(HomeTopViewHomeBtnPressed)homeBtnPressed tabCellPressed:(HomeTopTabCellPressed)tabCellPressed;


/**
 跳转到制定index
 @param index s
 */
- (void)updateJumpLineTo:(NSInteger)index;

@end


@interface HomeTopView (HomeTopView_extension)<UICollectionViewDelegate,UICollectionViewDataSource>

@end

