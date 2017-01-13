//
//  ScreeningVIew.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/12.
//
//

#import "ScreeningView.h"
#import "UIView+WJYExtension.h"

@interface ScreeningView()
@property (nonatomic,weak) UIView *contentView;
@property (nonatomic,assign)  BOOL isfirst;
@end

@implementation ScreeningView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isfirst = NO;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIView *contentView = [[UIView alloc] init];
    contentView.frame = CGRectMake(60, 0, self.width - 60, self.height);
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    self.contentView = contentView;
    
    [self slideToLeftWithAnimation];
}

///左划
- (void)slideToLeftWithAnimation {
    self.contentView.transform = CGAffineTransformMakeTranslation(self.width, 0);
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
    }];
}

///右划
- (void)slideToRightWithAnimation {
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(self.width, 0);
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}

///返回最适合处理事件的 View
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    self.isfirst = !self.isfirst;
    if ([view isKindOfClass:[ScreeningView class]] && self.isfirst) {
        [self slideToRightWithAnimation];
    }
    return view;
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self slideToRightWithAnimation];
//}

@end
