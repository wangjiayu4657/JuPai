//
//  HeaderView.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/13.
//
//

#import "HeaderView.h"
#import "UIView+WJYExtension.h"
#import "ScreenModel.h"

@interface HeaderView ()

/** 标题 */
@property (nonatomic,strong)  UILabel *titleLabel;

@end

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.frame = CGRectMake(15, 0, self.width/3, self.height);
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = [UIColor lightGrayColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}


-(void)setModel:(ScreenModel *)model {
    _model = model;
    self.titleLabel.text = model.type;
}


@end
