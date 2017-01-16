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
/** <#desciption#> */
@property (nonatomic,strong) UIButton *selectedButton;

@end

@implementation SortViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.contentButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setItems:(Items *)items {
    _items = items;
    [self.contentButton setTitle:items.item_Title forState:UIControlStateNormal];
    [self.contentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.contentButton setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
    if(items.indexPath.section == 0 && items.indexPath.item == 0) {
        NSLog(@"%@",items.indexPath);
        self.contentButton.enabled = NO;
        self.selectedButton = self.contentButton;
    }
}

- (void)buttonClick:(UIButton *) btn {
    self.selectedButton.enabled = YES;
    btn.enabled = NO;
    self.selectedButton = btn;
    NSLog(@"%s",__func__);
}

@end
