//
//  VerticalButton.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/10.
//
//

#import "VerticalButton.h"

@implementation VerticalButton

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void) setUp {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    CGRect imageFrame = self.imageView.frame;
    imageFrame.origin.x = (self.bounds.size.width - self.imageView.bounds.size.width) / 2;;
    imageFrame.origin.y = 10;
    imageFrame.size.width = self.imageView.bounds.size.width;
    imageFrame.size.height = self.imageView.bounds.size.height;
    self.imageView.frame = imageFrame;
    
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = 0;
    titleFrame.origin.y = CGRectGetMaxY(self.imageView.frame) - 10;
    titleFrame.size.width = self.bounds.size.width;
    titleFrame.size.height = self.bounds.size.height - titleFrame.origin.y;
    self.titleLabel.frame = titleFrame;
}

@end
