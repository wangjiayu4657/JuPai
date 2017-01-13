//
//  BottomView.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/13.
//
//

#import "BottomView.h"

@implementation BottomView

-(void)awakeFromNib {
    [super awakeFromNib];
    
    
    
}

+(instancetype)bottomView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
}


@end
