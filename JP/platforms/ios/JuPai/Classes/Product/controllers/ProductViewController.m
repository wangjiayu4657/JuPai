//
//  ProductViewController.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/6.
//
//

#import "ProductViewController.h"
#import "FixedIncomeVController.h"
#import "FloatingProfitController.h"
#import "SunlightPrivateController.h"
#import "InsuranceController.h"
#import "UIView+WJYExtension.h"
#import "UIColor+Hex.h"
#import "ScreeningView.h"


#define titlesViewHeight 44
#define titlesViewY 0
#define Height [UIScreen mainScreen].bounds.size.height

@interface ProductViewController ()<UIScrollViewDelegate>
///标题视图
@property (nonatomic,weak) UIView *titlesView;
///红色指示条
@property (nonatomic,weak) UIView *indcatorView;
///选中的按钮
@property (nonatomic,strong) UIButton *selectedButton;
///为了让 view 可以滑动,装 view 的容器视图
@property (nonatomic,weak) UIScrollView *contentView;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产品";
    self.view.backgroundColor = [UIColor colorWithHex:0XF0F0F0];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBar_new_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(searchItemClick)];
    self.navigationItem.rightBarButtonItem = barItem;
    [self setupChildController];
    [self setupTitleButtonView];
    [self setupContentView];
}

///添加标题按钮视图
- (void)setupTitleButtonView {
    //标题背景视图
    UIView *titlesView = [[UIView alloc] init];
    titlesView.width = self.view.width;
    titlesView.height = titlesViewHeight;
    titlesView.y = titlesViewY;
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.85];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //标题下面的红色指示条
    UIView *indcatorView = [[UIView alloc] init];
    indcatorView.height = 2;
    indcatorView.y = titlesView.height - indcatorView.height;
    indcatorView.backgroundColor = [UIColor redColor];
    [self.view addSubview:indcatorView];
    self.indcatorView = indcatorView;
    
    CGFloat width = titlesView.width / (self.childViewControllers.count + 1);
    CGFloat height = titlesView.height;
    //循环添加标题按钮
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIViewController *controller = self.childViewControllers[i];
        btn.tag = i + 300;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:controller.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(i * width, 0, width, height);
        [titlesView addSubview:btn];
        //默认选中第一个
        if (i == 0) {
            btn.enabled = NO;
            self.selectedButton = btn;
            [btn.titleLabel sizeToFit];
            self.indcatorView.width = btn.titleLabel.width;
            self.indcatorView.centerX = btn.centerX;
        }
    }
    //标题按钮中筛选按钮的容器视图
    UIView *screeningView = [[UIView alloc] init];
    screeningView.frame = CGRectMake(width * 4, 0, width, height);
    screeningView.backgroundColor = [UIColor clearColor];
    //分割线
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, screeningView.height / 4, 1, screeningView.height / 2);
    lineView.backgroundColor = [UIColor lightGrayColor];
    [screeningView addSubview:lineView];
    //筛选按钮
    UIButton *screenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    screenBtn.frame = CGRectMake(lineView.width, 0, screeningView.width - lineView.width, screeningView.height);
    [screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [screenBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [screenBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    screenBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    screenBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [screenBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [screenBtn addTarget:self action:@selector(screenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [screeningView addSubview:screenBtn];
    
    [self.view addSubview:screeningView];
}

///添加子控制器
-(void)setupChildController {
    FixedIncomeVController *fixedController = [[FixedIncomeVController alloc] init];
    fixedController.title = @"固定收益";
    [self addChildViewController:fixedController];
    
    FloatingProfitController *floatingController = [[FloatingProfitController alloc] init];
    floatingController.title = @"浮动收益";
    [self addChildViewController:floatingController];
    
    SunlightPrivateController *sunController = [[SunlightPrivateController alloc] init];
    sunController.title = @"阳光私募";
    [self addChildViewController:sunController];
    
    InsuranceController *insuranceController = [[InsuranceController alloc] init];
    insuranceController.title = @"保险";
    [self addChildViewController:insuranceController];
}

///添加使子控制器能左右滑动的容器视图
- (void)setupContentView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
    [self.view insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
    
}
#pragma mark - 按钮响应事件
///顶部标题按钮
- (void)btnClick:(UIButton *) button {
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indcatorView.width = button.titleLabel.width;
        self.indcatorView.centerX = button.centerX;
    }];
    
    CGPoint offset = self.contentView.contentOffset;
    offset.x = (button.tag - 300) * self.view.width;
    [self.contentView setContentOffset:offset animated:YES];
}

///筛选按钮
- (void)screenBtnClick {
    ScreeningView *sView = [[ScreeningView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    sView.frame = CGRectMake(0, 110, self.view.width, Height - 110);
    sView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:sView];
}

///搜索按钮
- (void)searchItemClick {
    NSLog(@"%s", __FUNCTION__);
    
}

#pragma mark -<scrollViewDelegate>
///停止动画时调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // scrollView 的偏移量
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIViewController *controller = self.childViewControllers[index];
    controller.view.x = scrollView.contentOffset.x;
    controller.view.y = 0;
    controller.view.height = scrollView.height;
    [scrollView addSubview:controller.view];
    
}

///停止减速是调用
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x / scrollView.width + 300;
    //根据 tag 值取出 button
    [self btnClick:[self.view viewWithTag:index]];
}
@end
