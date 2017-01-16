//
//  MyHeaderView.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/16.
//
//

#import "MyHeaderView.h"

@interface MyHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *backView;


@end

@implementation MyHeaderView

-(void)didMoveToSuperview {
    self.backView.backgroundColor = [UIColor colorWithRed:240/255.0 green:95/255.0 blue:32/255.0 alpha:1.0];
}

+(instancetype)shareMyHearderView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
}

@end
