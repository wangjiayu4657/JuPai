//
//  BaseViewController.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/6.
//
//

#import "BaseViewController.h"
#import "HomeViewController.h"
#import "ProductViewController.h"
#import "MyViewController.h"
#import "BaseNavigationController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

+ (void)initialize
{
    if (self == [BaseViewController class]) {
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:241 / 255.0 green:95 / 255.0 blue:31 / 255.0 alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:241 / 255.0 green:95 / 255.0 blue:31 / 255.0 alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateSelected];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpChildController:[[HomeViewController alloc] init] itemTitle:@"首页" image:@"icon_index_tab" selectImage:@"icon_index_tab_selected"];
    [self setUpChildController:[[ProductViewController alloc] init] itemTitle:@"产品" image:@"icon_product_tab" selectImage:@"icon_product_tab_selected"];
    [self setUpChildController:[[MyViewController alloc] init] itemTitle:@"我的" image:@"icon_porfile_tab" selectImage:@"icon_porfile_tab_selected"];
}

- (void) setUpChildController:(UIViewController *)controller itemTitle:(NSString *)title image:(NSString *) image selectImage:(NSString *) selectImage {
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:image];
    controller.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
    
    [self addChildViewController:nav];
}

@end
