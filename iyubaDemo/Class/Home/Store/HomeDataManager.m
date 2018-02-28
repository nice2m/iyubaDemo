//
//  HomeDataManager.m
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//
#import <Ono.h>

#import "HomeDataManager.h"
#import "NetworkManager.h"
#import "BBCTitleModel.h"


@interface HomeDataManager()

@property (nonatomic, assign) NSInteger currentPageNo;


@end


@implementation HomeDataManager


- (void)fetchNextPage {
    
    [[NetworkManager sharedManager] postUrl:@"http://apps.iyuba.com/minutes/titleNewApi.jsp?maxid=0&format=xml&type=android" parameter:@{} completeHandler:^(id responsObject, NSError *error) {
        NSLog(@"%@",responsObject);
        [self parseXMLwithData:responsObject];
    }];
}

//MARK: - private
- (void) parseXMLwithData:(NSData *)data{
    NSError * documentError = nil;
    ONOXMLDocument * document = [ONOXMLDocument XMLDocumentWithData:data error:&documentError];
    if (documentError) {
        NSLog(@"%@",documentError);
        return;
    }
    
    [document.rootElement enumerateElementsWithXPath:@"Bbctitle" usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
        // NSLog(@"%@",element);
        NSMutableDictionary * modelDict = [NSMutableDictionary dictionary];
        for (ONOXMLElement * tmpElement in element.children) {
            NSLog(@"%@",tmpElement.tag);
            modelDict[tmpElement.tag] = tmpElement.stringValue;
        }
        BBCTitleModel * model = [BBCTitleModel yy_modelWithDictionary:modelDict];
        [self.dataSource addObject:model];
    }];
    
}

- (NSMutableArray<BBCTitleModel *> *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


@end
