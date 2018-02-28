//
//  ViewController.m
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import <AFNetworking.h>
#import <ONOXMLDocument.h>
#import <Masonry/Masonry.h>

#import "ViewController.h"
#import "NetworkManager.h"
#import "BBCTitleModel.h"
#import "HomeDataManager.h"
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

static NSString * kHomeTableViewCellReuseId = @"HomeIndexCell";

@interface ViewController ()

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * topContainerView;
@property (nonatomic, strong) UIView * centerContainerView;
@property (nonatomic, strong) UIView * bottomContainerView;

@property (nonatomic, strong)HomeDataManager *dataManager;

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
- (void)configUI{
    _topContainerView = [UIView new];
    [self.view addSubview:_topContainerView];
    
    _centerContainerView = [UIView new];
    [self.view addSubview:_centerContainerView];
    
    _bottomContainerView = [UIView new];
    [self.view addSubview:_bottomContainerView];
#warning "    // TODO: "

    // 布局tableview
    _tableView = [[UITableView alloc] init];
    [_centerContainerView addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UINib * nib = [UINib nibWithNibName:kHomeTableViewCellReuseId bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:kHomeTableViewCellReuseId];
    
}

- (void)config{
    _dataManager = [[HomeDataManager alloc] init];
}

@end


@implementation ViewController(delegate)

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@""];
    return  cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataManager.dataSource.count;
}

@end


