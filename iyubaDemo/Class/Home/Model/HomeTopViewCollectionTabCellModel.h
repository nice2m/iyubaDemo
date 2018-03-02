//
//  HomeTopViewCollectionTabCellModel.h
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTopViewCollectionTabCellModel : NSObject

/**
 标题字符
 */
@property (nonatomic, copy) NSString * title;

/**
 标题是否是已经选中状态，标记
 */
@property (nonatomic, assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
