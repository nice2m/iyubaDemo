//
//  ViewController.m
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import <ONOXMLDocument.h>
#import <MJRefresh/MJRefresh.h>

#import "NetworkManager.h"
#import "BBCTitleModel.h"
#import "HomeDataManager.h"

#import "ViewController.h"

#import "HomeTopView.h"
#import "HomeScrollPageView.h"
#import "HomeFooterView.h"
#import "HomeIndexCell.h"
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
@property (nonatomic, strong) UIView * scrollContainerView;
@property (nonatomic, strong) UIView * tableContainerView;
@property (nonatomic, strong) UIView * bottomContainerView;

@property (nonatomic, strong) HomeTopView * homeTopView;
@property (nonatomic, strong) HomeScrollPageView * homeScrollTopView;
@property (nonatomic, strong) HomeFooterView * homeFooterView;
@property (nonatomic, strong) HomeDataManager *dataManager;

@end

@implementation ViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configUI];
    [self config];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void)configUI{
    _topContainerView = [UIView new];
    [self.view addSubview:_topContainerView];
    
    _scrollContainerView = [UIView new];
    [self.view addSubview:_scrollContainerView];
    
    _tableContainerView = [UIView new];
    [self.view addSubview:_tableContainerView];
    
    _bottomContainerView = [UIView new];
    [self.view addSubview:_bottomContainerView];

    // 布局tableview
    _tableView = [[UITableView alloc] init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableContainerView addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_tableContainerView);
    }];
    UINib * nib = [UINib nibWithNibName:kHomeTableViewCellReuseId bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:kHomeTableViewCellReuseId];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    
    //容器视图布局；
    
    [_topContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20.0);
        make.leading.trailing.equalTo(self.view);
        make.height.equalTo(@88.0);
    }];
    
    [_scrollContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topContainerView.mas_bottom);
        make.leading.trailing.equalTo(self.view);
        make.height.equalTo(@172.0);
    }];
    
    [_tableContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollContainerView.mas_bottom);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(_bottomContainerView.mas_top);
    }];
    
    [_bottomContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(self.view);
        make.height.equalTo(@88.0);
    }];
    
    //配置 HomeTopView
    NSArray * titles = @[@"BBC六分钟",@"地道英语",@"BBC新闻",@"新闻词汇"];
    
    UIImage * topBgImg = [UIImage imageNamed:@"logo"];
    CGFloat collectionCellSpacing = kHomeTopViewCellSpacing;
    
    CGFloat contentWidht = kScreenWidth - (titles.count - 1) * collectionCellSpacing;
    
    CGSize tabCellSize = CGSizeMake(contentWidht / titles.count, 44.0);
    _homeTopView = [[HomeTopView alloc] initWithFrame:CGRectZero titles:titles topBgImg:topBgImg tabCellSize:tabCellSize homeBtnPressed:^{
        NSLog(@"homeBtnPressed");
#warning "首页按钮点击"
    } tabCellPressed:^(NSInteger tapIndex) {
#warning "标题按钮点击"
        NSLog(@"tabCellPressed \t%ld",(long)tapIndex);
        [_homeTopView updateJumpLineTo:tapIndex];
    }];
    
    [_topContainerView addSubview:_homeTopView];
    [_homeTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_topContainerView);
    }];
    
    // 配置cyclePageView
    _homeScrollTopView = [[HomeScrollPageView alloc] initWithFrame:CGRectZero imagesUrlArray:@[] imgOnTapBlock:^(NSInteger index) {
        NSLog(@"HomeScrollPageView imgOnTapBlock :%ld ",index);
    }];
    [_scrollContainerView addSubview:_homeScrollTopView];
    [_homeScrollTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollContainerView);
    }];
    
    // 配置footer
    _homeFooterView = [[HomeFooterView alloc] initWithFrame:CGRectZero lastBtnBlock:^{
#warning "上一页"

        NSLog(@"lastBtnBlock");
    } nextBtnBlock:^{
#warning "下一页"

        NSLog(@"nextBtnBlock");
    } bottomImgBlock:^{
#warning "底部图片点击"

        NSLog(@"bottomImgBlock");
    }];
    [_bottomContainerView addSubview: _homeFooterView];
    [_homeFooterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_bottomContainerView);
    }];
    
}

- (void)config{
    _dataManager = [[HomeDataManager alloc] initWith:self];
    [self refreshData];
}

- (void)refreshData {
    __weak typeof (self) weakSelf = self;
    
    [_dataManager fetchData:^(id responsObject, NSError *error) {
        NSLog(@"responseObject:%@\n\nerror:%@\n\n",responsObject,error);
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView.mj_header endRefreshing];
            [weakSelf.tableView reloadData];
            [_homeScrollTopView updateImages:[_dataManager cycleImages]];
        });
    }];
}

@end


@implementation ViewController(delegate)

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HomeIndexCell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeTableViewCellReuseId];
    [cell configModel:self.dataManager.dataSource[indexPath.row]];
    if (indexPath.row == 0){
        [cell showTopImaginary];
    }
    
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 76.0f;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataManager.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}
@end


