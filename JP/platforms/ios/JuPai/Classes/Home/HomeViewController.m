//
//  HomeViewController.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/6.
//
//

#import "HomeViewController.h"
#import "FixedIncomeCell.h"
#import "HomeBannerView.h"
#import "MJRefresh.h"
#import "HttpClient.h"

static NSString * const cellReuseIdentifier = @"cellReuseIdentifier";

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , weak) UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钜派在线";
    
    [self setUpTableView];
}

- (void) setUpTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor lightGrayColor];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FixedIncomeCell class]) bundle:nil] forCellReuseIdentifier:cellReuseIdentifier];
    self.tableView = tableView;
    HomeBannerView *bannerView = [[HomeBannerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 140)];
    self.tableView.tableHeaderView = bannerView;
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void) loadData {
//    NSString *path = @"http://10.0.60.44:4100/api/apiVersion/mobile/v3/login";
    NSString *paths = @"http://10.0.60.44:4100/api/apiVersion/mobile/v3/lcs/projects/hot/mobile";
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:4];
//    param[@"appVersion"] = NULL;
//    param[@"mode"] = @"lcs";
//    param[@"password"] = @"W12345678";
//    param[@"username"] = @"13911111110";
      param[@"pageIndex"] = @"1";
      param[@"pageSize"] = @"8";
    
    [HttpClient.sharedClient postPath:paths params:param resultBlock:^(id responseObject, NSError *error) {
        NSLog(@"%@",responseObject);
        [self.tableView.mj_header endRefreshing];
    }];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FixedIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 152;
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
