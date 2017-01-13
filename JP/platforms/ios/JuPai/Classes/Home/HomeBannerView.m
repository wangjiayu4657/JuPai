//
//  HomeBannerView.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/7.
//
//

#import "HomeBannerView.h"
#import "HttpClient.h"


@interface HomeBannerView() <SDCycleScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *urlArray;
@end

@implementation HomeBannerView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
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
    
    self.imageURLStringsGroup = imagesURLStrings;
    self.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.delegate = self;
//    self.titlesGroup = titles;
    // 自定义分页控件小圆标颜色
    self.currentPageDotColor = [UIColor yellowColor];
    self.placeholderImage = [UIImage imageNamed:@"placeholder"];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%zd",index);
}



@end
