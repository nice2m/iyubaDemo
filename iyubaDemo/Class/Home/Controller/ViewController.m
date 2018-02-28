//
//  ViewController.m
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <ONOXMLDocument.h>
#import "NetworkManager.h"
#import "BBCTitleModel.h"
#import <Masonry/Masonry.h>
/*
 #import "Ono.h"
 
 NSData *data = ...;
 NSError *error;
 
 ONOXMLDocument *document = [ONOXMLDocument XMLDocumentWithData:data error:&error];
 for (ONOXMLElement *element in document.rootElement.children) {
 NSLog(@"%@: %@", element.tag, element.attributes);
 }
 
 // Support for Namespaces
 NSString *author = [[document.rootElement firstChildWithTag:@"creator" inNamespace:@"dc"] stringValue];
 
 // Automatic Conversion for Number & Date Values
 NSDate *date = [[document.rootElement firstChildWithTag:@"created_at"] dateValue]; // ISO 8601 Timestamp
 NSInteger numberOfWords = [[[document.rootElement firstChildWithTag:@"word_count"] numberValue] integerValue];
 BOOL isPublished = [[[document.rootElement firstChildWithTag:@"is_published"] numberValue] boolValue];
 
 // Convenient Accessors for Attributes
 NSString *unit = [document.rootElement firstChildWithTag:@"Length"][@"unit"];
 NSDictionary *authorAttributes = [[document.rootElement firstChildWithTag:@"author"] attributes];
 
 // Support for XPath & CSS Queries
 [document enumerateElementsWithXPath:@"//Content" usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
 NSLog(@"%@", element);
 }];
 */
@interface ViewController ()

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * topContainerView;
@property (nonatomic, strong) UIView * centerContainerView;
@property (nonatomic, strong) UIView * bottomContainerView;

@end

@implementation ViewController


#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private





@end
