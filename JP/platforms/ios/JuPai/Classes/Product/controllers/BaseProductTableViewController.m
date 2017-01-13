//
//  BaseProductTableViewController.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/11.
//
//

#import "BaseProductTableViewController.h"
#import "FixedIncomeCell.h"
#import "FloatingProfitCell.h"
#import "SunlightPrivateCell.h"
#import "InsuranceTableViewCell.h"
#import "ProductModel.h"
#import "HttpClient.h"
#import "MJExtension.h"
#import "UIColor+Hex.h"
#import "MJRefresh.h"
#import "ProductModel.h"


@interface BaseProductTableViewController ()
///数据源
@property (nonatomic , strong) NSMutableArray *datasArray;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) ProductModel *model;

@end

@implementation BaseProductTableViewController

- (NSMutableArray *)datasArray {
    if (!_datasArray) {
        _datasArray = [NSMutableArray array];
    }
    return _datasArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:0xF0F0F0];
    self.model = [[ProductModel alloc] init];
    [self setupTableView];
}

- (void) setupTableView {
    
    self.tableView.contentInset = UIEdgeInsetsMake(46, 0, 100, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FixedIncomeCell class]) bundle:nil] forCellReuseIdentifier:FixedIncomeCellReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FloatingProfitCell class]) bundle:nil] forCellReuseIdentifier:FloatingProfitCellReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SunlightPrivateCell class]) bundle:nil] forCellReuseIdentifier:SunlightPrivateCellReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([InsuranceTableViewCell class]) bundle:nil] forCellReuseIdentifier:InsuranceTableViewCellReuseIdentifier];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self downloadContent];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    //上拉刷新
    MJRefreshAutoNormalFooter *footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self pullOnLoading];
    }];
    // 设置文字
    [footer setTitle:@"点击或拖拽进行刷新" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    // 设置颜色
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    // 设置footer
    self.tableView.mj_footer = footer;
    
    self.tableView.mj_footer.hidden = YES;
}

///下拉刷新
- (void)downloadContent {
        self.pageIndex = 1;
        NSString *url = @"http://10.0.60.44:4100/api/lcs/projects/filterProject";
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
        params[@"type"] = @(self.productType);
        params[@"pageIndex"] = @(self.pageIndex);
        params[@"pageSize"] = @(8);
        params[@"condition"] = nil;
        [[HttpClient sharedClient] postPath:url params:params resultBlock:^(id responseObject, NSError *error) {
            self.datasArray = [ProductModel mj_objectArrayWithKeyValuesArray:responseObject[@"dataList"]];
            self.model.totalPageCount = [responseObject[@"totalPageCount"] integerValue];
            if (self.pageIndex == self.model.totalPageCount) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableView.mj_header endRefreshing];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
}

///上拉刷新
- (void)pullOnLoading {
    self.pageIndex += 1;
    NSString *url = @"http://10.0.60.44:4100/api/lcs/projects/filterProject";
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
    params[@"type"] = @(self.productType);
    params[@"pageIndex"] = @(self.pageIndex);
    params[@"pageSize"] = @(8);
    params[@"condition"] = nil;
    [[HttpClient sharedClient] postPath:url params:params resultBlock:^(id responseObject, NSError *error) {
        NSArray *arr = [ProductModel mj_objectArrayWithKeyValuesArray:responseObject[@"dataList"]];
        [self.datasArray addObjectsFromArray:arr];
        if (self.pageIndex == self.model.totalPageCount) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.datasArray.count == 0);
    return self.datasArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    ProductModel *model  = nil;
    if (indexPath.row < self.datasArray.count) {
        model = self.datasArray[indexPath.row];
    }
    switch (_productType) {
        case 1: {
            FixedIncomeCell *fixedCell = [tableView dequeueReusableCellWithIdentifier:FixedIncomeCellReuseIdentifier];
            fixedCell.model = model;
            cell = fixedCell;
        }
            break;
        case 2: {
            FloatingProfitCell *floatCell = [tableView dequeueReusableCellWithIdentifier:FloatingProfitCellReuseIdentifier];
            floatCell.model = model;
            cell = floatCell;
        }
            break;
        case 3:{
            SunlightPrivateCell *sunCell = [tableView dequeueReusableCellWithIdentifier:SunlightPrivateCellReuseIdentifier];
            sunCell.model = model;
            cell = sunCell;
        }
            break;
        case 4:{
            InsuranceTableViewCell *insureanceCell = [tableView dequeueReusableCellWithIdentifier:InsuranceTableViewCellReuseIdentifier];
            insureanceCell.model = model;
            cell = insureanceCell;
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductModel *model = self.datasArray[indexPath.row];
    return model.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
