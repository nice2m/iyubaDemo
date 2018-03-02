//
//  BBCTitleModel.h
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 <BbcId>1127</BbcId>
 <Title>Bitcoin: digital crypto-currency</Title>
 <DescCn> 今天的六分钟英语讨论著名的加密货币，比特币。</DescCn>
 <Title_cn> 比特币：数字加密货币</Title_cn>
 <Category>1</Category>
 <Sound>1127.mp3</Sound>
 <Url>http://www.bbc.co.uk/learningenglish/english/features/6-minute-english/ep-180104</Url>
 <Pic>http://static.iyuba.com/images/minutes/1127.jpg</Pic>
 <CreatTime>2018-01-17 22:14:19.0</CreatTime>
 <PublishTime>null</PublishTime>
 <ReadCount>133559</ReadCount>
 <HotFlg>0</HotFlg>
 */

NS_ASSUME_NONNULL_BEGIN


/**
 首页数据展示模型；
 */
@interface BBCTitleModel : BaseModel


@property (nonatomic, copy) NSString * bbcId;

/**
 文章标题（英文）
 */
@property (nonatomic, copy) NSString * title;

/**
 文章标题（中文）

 */
@property (nonatomic, copy) NSString * title_cn;
@property (nonatomic, copy) NSString * descCn;

/**
 所属类别
 */
@property (nonatomic, copy) NSString * category;

/**
 声音文件ID
 */
@property (nonatomic, copy) NSString * sound;

@property (nonatomic, copy) NSString * url;

/**
 图片URL 地址
 */
@property (nonatomic, copy) NSString * pic;

/**
 文章创建日期
 */
@property (nonatomic, copy) NSString * creatTime;

@property (nonatomic, copy) NSString * publishTime;

/**
 文章阅读数
 */
@property (nonatomic, copy) NSString * readCount;

@property (nonatomic, copy) NSString * hotFlg;

//
@end

NS_ASSUME_NONNULL_END
