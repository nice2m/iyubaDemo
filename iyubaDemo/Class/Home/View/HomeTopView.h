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

@interface HomeTopView : UIView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *>*)titles topBgImg:(UIImage *)topBgImg tabCellSize:(CGSize)tabCellSize homeBtnPressed:(HomeTopViewHomeBtnPressed)homeBtnPressed tabCellPressed:(HomeTopTabCellPressed)tabCellPressed;


/**
 跳转到制定index

 @param index
 */
- (void)updateJumpLineTo:(NSInteger)index;

@end


@interface HomeTopView (HomeTopView_extension)<UICollectionViewDelegate,UICollectionViewDataSource>

@end

