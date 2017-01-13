//
//  HomeViewController.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/6.
//
//

#import "HomeViewController.h"
#import "FixedIncomeCell.h"
#import "FloatingProfitCell.h"
#import "SunlightPrivateCell.h"
#import "InsuranceTableViewCell.h"
#import "HomeBannerView.h"
#import "MJRefresh.h"
#import "HttpClient.h"
#import "ProductModel.h"
#import "MJExtension.h"
#import "UIView+WJYExtension.h"


@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , weak) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic, strong) ProductModel *model;
@property (nonatomic,assign) NSInteger pageIndex;

@end

@implementation HomeViewController



-(NSMutableArray *) dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钜派在线";
    self.model = [[ProductModel alloc] init];
    [self setUpTableView];
    
}

- (void)setUpTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    // 设置 tableView 的显示区域
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    //设置滑动条的显示区域
    tableView.scrollIndicatorInsets = tableView.contentInset;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0  blue:243 / 255.0  alpha:1.0];
    //注册 cell
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FixedIncomeCell class]) bundle:nil] forCellReuseIdentifier:FixedIncomeCellReuseIdentifier];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FloatingProfitCell class]) bundle:nil] forCellReuseIdentifier:FloatingProfitCellReuseIdentifier];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SunlightPrivateCell class]) bundle:nil] forCellReuseIdentifier:SunlightPrivateCellReuseIdentifier];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([InsuranceTableViewCell class]) bundle:nil] forCellReuseIdentifier:InsuranceTableViewCellReuseIdentifier];
    self.tableView = tableView;
    HomeBannerView *bannerView = [[HomeBannerView alloc] init];
    bannerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, bannerView.viewHeight);
    self.tableView.tableHeaderView = bannerView;
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self download];
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

- (void) download {
    BOOL loginSuccess = YES;
    if (loginSuccess) {
        [self loadData];
    } else {
        [self login];
    }
}

- (void) login {
    NSString *path = @"http://10.0.60.44:4100/api/apiVersion/mobile/v3/login";
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:4];
    
    param[@"appVersion"] = NULL;
    param[@"mode"] = @"lcs";
    param[@"password"] = @"W12345678";
    param[@"username"] = @"13911111110";
    
    [HttpClient.sharedClient postPath:path params:param resultBlock:^(id responseObject, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

///下拉刷新
- (void) loadData {
    self.pageIndex = 1;
    NSString *paths = @"http://10.0.60.44:4100/api/apiVersion/mobile/v3/lcs/projects/hot/mobile";
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:4];
    param[@"pageIndex"] = @(self.pageIndex);
    param[@"pageSize"] = @"8";
    
    [HttpClient.sharedClient postPath:paths params:param resultBlock:^(id responseObject, NSError *error) {
        //字典数组-->模型数组
        NSArray *arr = [ProductModel mj_objectArrayWithKeyValuesArray:responseObject[@"dataList"]];
        [self.dataArray addObjectsFromArray:arr];
        self.model.totalCount = [responseObject[@"totalCount"] integerValue];
        if (self.dataArray.count == self.model.totalCount) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView.mj_header endRefreshing];
        //刷新界面
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableView.dataSource = self;
            self.tableView.delegate = self;
            [self.tableView reloadData];
        });
    }];
}

///上拉加载
- (void)pullOnLoading {
    
    self.pageIndex += 1;
    NSString *paths = @"http://10.0.60.44:4100/api/apiVersion/mobile/v3/lcs/projects/hot/mobile";
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:4];
    param[@"pageIndex"] = @(self.pageIndex);
    param[@"pageSize"] = @(8);
    [HttpClient.sharedClient postPath:paths params:param resultBlock:^(id responseObject, NSError *error) {
        NSArray *arr = [ProductModel mj_objectArrayWithKeyValuesArray:responseObject[@"dataList"]];
        [self.dataArray addObjectsFromArray:arr];
        //如果总数据就一页,那么第一次请求就拿到了所有的数据,这是就提示用户没有更多数据了,否则结束本次的刷新
        if (self.dataArray.count == self.model.totalCount) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //当有数据时才显示底部刷新控件,否则隐藏
    self.tableView.mj_footer.hidden = (self.dataArray.count == 0);
    return self.dataArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    ProductModel *model = nil;
    if (indexPath.row < self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    switch (model.productType) {
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
    ProductModel *model = self.dataArray[indexPath.row];
    return model.rowHeight;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
