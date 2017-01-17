//
//  MyViewController.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/6.
//
//

#import "MyViewController.h"
#import "MyHeaderView.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 数据源 */
@property (nonatomic,strong) NSArray *contentArray;
/** 图片 */
@property (nonatomic,strong) NSArray *imagesArray;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    self.contentArray = @[
                          @[@"我的订单",@"我的客户",@"我的佣金"],
                          @[@"我的赎回",@"存续报告"],
                          @[@"个人信息",@"安全中心"]
                        ];
    self.imagesArray = @[
                         @[@"icon_order_list",@"icon_customer_list",@"icon_commision_list"],
                         @[@"icon_porfile_tab_selected",@"icon_product_tab_selected"],
                         @[@"icon_porfile_tab_selected",@"icon_school_tab_selected"]
                        ];
    [self setupTableView];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
    tableView.scrollIndicatorInsets = tableView.contentInset;
    tableView.tableHeaderView = [MyHeaderView shareMyHearderView];
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableView];
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.contentArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.contentArray[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    }
    cell.imageView.image = [UIImage imageNamed:self.imagesArray[indexPath.section][indexPath.row]];
    cell.textLabel.text = self.contentArray[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
//    return view;
//}



@end
