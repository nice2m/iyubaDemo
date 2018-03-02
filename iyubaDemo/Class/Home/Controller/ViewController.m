//
//  ViewController.m
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import <ONOXMLDocument.h>
#import <MJRefresh/MJRefresh.h>
#import "UIViewController+toast.h"

#import "NetworkManager.h"
#import "HomeDataManager.h"
#import "BBCTitleModel.h"

#import "ViewController.h"

#import "HomeTopView.h"
#import "HomeScrollPageView.h"
#import "HomeFooterView.h"
#import "HomeIndexCell.h"

// 首页TableView 复用标识
static NSString * kHomeTableViewCellReuseId = @"HomeIndexCell";


@interface ViewController ()

/**
 顶部导航栏容器视图
 */
@property (nonatomic, strong) UIView * topContainerView;

/**
 scrollPage 容器视图
 */
@property (nonatomic, strong) UIView * scrollContainerView;

/**
 新闻tableView 容器视图
 */
@property (nonatomic, strong) UIView * tableContainerView;

/**
 新闻 tableView
 */
@property (nonatomic, strong) UITableView * tableView;

/**
 底部footer 容器视图
 */
@property (nonatomic, strong) UIView * bottomContainerView;


/**
 自定义视图，首页导航栏视图
 */
@property (nonatomic, strong) HomeTopView * homeTopView;

/**
 自定义视图，scrollPage 视图
 */
@property (nonatomic, strong) HomeScrollPageView * homeScrollTopView;

/**
 首页自定义视图，底部脚标视图
 */
@property (nonatomic, strong) HomeFooterView * homeFooterView;

/**
 MVCS Store 数据处理对象
 */
@property (nonatomic, strong) HomeDataManager *dataManager;

/**
 数据cate 标记
 */
@property (nonatomic, assign) NSInteger currentParentId;

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



/**
 跳转应用外打开URL

 @param urlString 要打开的URL地址
 */
- (void)openURL:(NSString *)urlString{
    NSURL * url = [NSURL URLWithString:urlString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

/**
 alert 提示，并且执行操作

 @param msg alert 的信息
 @param complete 确认执行的操作
 */
- (void)showAlert:(NSString *)msg completBlock:(void(^)(void))complete{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"cancled");
    }];
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        complete();
    }];
    [alertVC addAction:confirm];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:true completion:nil];

}

/**
 配置布局视图
 */
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
        [self ex_showToast:@"首页按钮点击"];
        
    } tabCellPressed:^(NSInteger tapIndex) {
        NSLog(@"tabCellPressed \t%ld",(long)tapIndex);
        [_homeTopView updateJumpLineTo:tapIndex];
        self.currentParentId = tapIndex + 1;
        [self refreshData];
    }];
    
    [_topContainerView addSubview:_homeTopView];
    [_homeTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_topContainerView);
    }];
    
    // 配置cyclePageView
    _homeScrollTopView = [[HomeScrollPageView alloc] initWithFrame:CGRectZero imagesUrlArray:@[] imgOnTapBlock:^(NSInteger index) {
        NSLog(@"HomeScrollPageView imgOnTapBlock :%ld ",index);
        [self ex_showToast:[NSString stringWithFormat:@"点击第%ld张",index + 1]];
        
    }];
    [_scrollContainerView addSubview:_homeScrollTopView];
    [_homeScrollTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollContainerView);
    }];
    
    // 配置footer
    _homeFooterView = [[HomeFooterView alloc] initWithFrame:CGRectZero lastBtnBlock:^{
        [self ex_showToast:@"上一页点击"];
        
        NSLog(@"lastBtnBlock");
    } nextBtnBlock:^{
        
        NSLog(@"nextBtnBlock");
        [self ex_showToast:@"下一页点击"];
        
    } bottomImgBlock:^{
        [self showAlert:@"跳转到腾讯应用市场？" completBlock:^{
            [self openURL:kTencentAppCenterURL];
        }];
    }];
    [_bottomContainerView addSubview: _homeFooterView];
    [_homeFooterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_bottomContainerView);
    }];
}


/**
 基本配置
 */
- (void)config{
    _dataManager = [[HomeDataManager alloc] initWith:self];
    _currentParentId = 1;
    [self refreshData];
}


/**
 请求刷新网络数据
 */
- (void)refreshData {
    
    [self ex_showHud:@"加载中"];
    __weak typeof (self) weakSelf = self;
    [_dataManager fetchDataWithParentID:weakSelf.currentParentId completeHandler:^(id responsObject, NSError *error) {
        [weakSelf ex_hideHud];
        [weakSelf.tableView.mj_header endRefreshing];
        if (error != nil){
            [weakSelf ex_showToast:@"加载失败"];
            return ;
        }
        [weakSelf.tableView reloadData];
        [weakSelf.homeScrollTopView updateImages:[weakSelf.dataManager cycleImagesWithParentID:weakSelf.currentParentId]];
    }];
}
@end



/**
 TableView  代理方法
 */
@implementation ViewController(delegate)

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HomeIndexCell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeTableViewCellReuseId];
    [cell configModel: [self.dataManager dataSourceWithParentId:self.currentParentId][indexPath.row]];
    if (indexPath.row == 0){
        [cell showTopImaginary];
    }
    
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 76.0f;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataManager dataSourceWithParentId:self.currentParentId].count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}
@end


