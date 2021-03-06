//
//  BBCTitleModel.m
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import "BBCTitleModel.h"

@implementation BBCTitleModel

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
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{ @"bbcId" : @"BbcId",
              @"title" : @"Title",
              @"descCn" : @"DescCn",
              @"title_cn" : @"Title_cn",
              @"ategory" : @"cCategory",
              @"sound" : @"Sound",
              @"url" : @"Url",
              @"pic" : @"Pic",
              @"creatTime" : @"CreatTime",
              @"publishTime" : @"PublishTime",
              @"readCount" : @"ReadCount",
              @"hotFlg" : @"HotFlg"};
}

@end
