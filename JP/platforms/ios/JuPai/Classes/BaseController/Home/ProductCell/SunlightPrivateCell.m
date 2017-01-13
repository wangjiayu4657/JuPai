//
//  SunlightPrivateCell.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/9.
//
//

#import "SunlightPrivateCell.h"
#import "ProductModel.h"
@interface SunlightPrivateCell()

///产品名称
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
///紧张标签
@property (weak, nonatomic) IBOutlet UIButton *shortageStatusLabel;
///产品小类
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;

///基金经理
@property (weak, nonatomic) IBOutlet UILabel *fundManagerLabel;
///佣金比例
@property (weak, nonatomic) IBOutlet UILabel *commissionProportionLabel;


@end

@implementation SunlightPrivateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ProductModel *)model {
    
    self.fundManagerLabel.text = @"";
    self.titleLabel.text = model.title;
    self.categoryNameLabel.text = model.categoryName;
    self.commissionProportionLabel.text = model.commissionProportion;
}


@end
