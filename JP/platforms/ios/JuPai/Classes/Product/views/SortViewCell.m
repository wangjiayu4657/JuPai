//
//  SortViewCell.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/13.
//
//

#import "SortViewCell.h"
#import "Items.h"

@interface SortViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *contentButton;


@end

@implementation SortViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}


-(void)setItem:(Items *)item {
    _item = item;
    [self.contentButton setTitle:item.item_Title forState:UIControlStateNormal];
    
}

@end
