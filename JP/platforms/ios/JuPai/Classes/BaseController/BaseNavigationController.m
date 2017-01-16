//
//  BaseNavigationController.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/10.
//
//

#import "BaseNavigationController.h"
#import "UIImage+Utilities.h"



@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

+ (void)initialize {
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithRed:240 / 255.0 green:95 / 255.0 blue:32 / 255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //隐藏导航栏下边的横线
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
