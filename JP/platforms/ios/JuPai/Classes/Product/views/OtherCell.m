//
//  OtherCell.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/13.
//
//

#import "OtherCell.h"
#import "Items.h"

@interface OtherCell ()

/** 内容按钮 */
@property (nonatomic,strong)  UIButton *contentButton;

@end


@implementation OtherCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.contentButton.frame = self.bounds;
        [self.contentButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.contentButton.titleLabel.font = [UIFont systemFontOfSize:15];
        self.contentButton.layer.borderWidth = 1.0;
        self.contentButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.contentButton.layer.masksToBounds = YES;
        self.contentButton.layer.cornerRadius = 5.0;
        [self.contentView addSubview:self.contentButton];
    }
    return self;
}

- (void)setItem:(Items *)item {
    _item = item;
    [self.contentButton setTitle:item.item_Title forState:UIControlStateNormal];
}

@end
