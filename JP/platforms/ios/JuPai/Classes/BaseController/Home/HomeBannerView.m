//
//  HomeBannerView.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/7.
//
//

#import "HomeBannerView.h"
#import "HttpClient.h"
#import "SDCycleScrollView.h"
#import "VerticalButton.h"


#define SWidth [UIScreen mainScreen].bounds.size.width

@interface HomeBannerView() <SDCycleScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *urlArray;
@property (nonatomic, weak) SDCycleScrollView *sView;
@property (nonatomic, strong) UIView *bgView;
@end

@implementation HomeBannerView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        [self loadData];
    }
    
    return self;
}

-(NSMutableArray *) urlArray {
    if (!_urlArray) {
        _urlArray = [NSMutableArray array];
    }
    return _urlArray;
}

-(void) setUpUI {
    SDCycleScrollView *sView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SWidth, 140)];
    [self addSubview:sView];
    self.sView = sView;
    
    NSArray *titles = @[@"订单管理",@"我的客户",@"佣金"];
    NSArray *images = @[@"icon_order_list",@"icon_customer_list",@"icon_commision_list"];
    UIView *toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sView.frame), SWidth, 70)];
    for (int i = 0; i < 3; i++) {
        VerticalButton *btn = [VerticalButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(SWidth / 3 * i, 0, SWidth / 3, 70);
        [toolBar addSubview:btn];
    }
    toolBar.backgroundColor = [UIColor whiteColor];
    [self addSubview:toolBar];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(toolBar.frame), SWidth, 30)];
    bgView.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1.0];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, bgView.frame.size.height)];
    label.text = @"精选理财";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    
    [bgView addSubview:label];
    [self addSubview:bgView];
    self.bgView = bgView;
}

-(CGFloat) viewHeight {
    return CGRectGetMaxY(self.bgView.frame);
}

-(void) loadData {
    
    NSString *path = @"http://10.0.60.44:4100/api/apiVersion/mobile/v3/lcs/getBannerImageInfo";
    __weak __typeof(self) weakSelf = self;
    [HttpClient.sharedClient getPath:path params:nil resultBlock:^(id responseObject, NSError *error) {
        for (NSDictionary *dict in responseObject) {
            [weakSelf.urlArray addObject:dict[@"url"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setUpUIWith:weakSelf.urlArray];
        });
    }];
}

- (void)setUpUIWith:(NSArray *) urls {
    NSArray *imagesURLStrings = urls;
                                  
    
    
//    NSArray *imagesURLStrings = @[
//                                  @"https://of6xuqx4l.qnssl.com/1010610.jpg",
//                                  @"https://of6xuqx4l.qnssl.com/1017537.jpg",
//                                  @"https://of6xuqx4l.qnssl.com/1010769-2.jpg",
//                                  @"https://of6xuqx4l.qnssl.com/jhb.png",
//                                  @"https://of6xuqx4l.qnssl.com/tzzs4.jpg"
//                                  ];
    
    // 图片配文字
//    NSArray *titles = @[@"感谢您的支持，如果下载的",
//                        @"如果代码在使用过程中出现问题",
//                        @"您可以发邮件到gsdios@126.com",
//                        ];
//    
    
    self.sView.imageURLStringsGroup = imagesURLStrings;
    self.sView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.sView.delegate = self;
//    self.titlesGroup = titles;
    // 自定义分页控件小圆标颜色
    self.sView.currentPageDotColor = [UIColor yellowColor];
    self.sView.placeholderImage = [UIImage imageNamed:@"placeholder"];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%zd",index);
}



@end
