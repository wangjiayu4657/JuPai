//
//  HomeTableViewCell.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/6.
//
//

#import "FixedIncomeCell.h"
#import "ProductModel.h"

@interface FixedIncomeCell()
///产品名称
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
///紧张标签
@property (weak, nonatomic) IBOutlet UIButton *shortageStatusLabel;
///产品小类
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;
///预期年化收益
@property (weak, nonatomic) IBOutlet UILabel *expectLabel;
///募集进度
@property (weak, nonatomic) IBOutlet UILabel *raiseProcessLabel;
///进度条
@property (weak, nonatomic) IBOutlet UIProgressView *progress;

///起投金额
@property (weak, nonatomic) IBOutlet UILabel *minInvestAmountLabel;
///投资期限
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;
///佣金比例
@property (weak, nonatomic) IBOutlet UILabel *commissionProportionLabel;

@end

@implementation FixedIncomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ProductModel *)model {
    self.minInvestAmountLabel.text = model.wanInvestAmount;
    self.limitLabel.text = model.limit;
    self.titleLabel.text = model.title;
    self.categoryNameLabel.text = model.categoryName;
    self.expectLabel.text = model.expect;
    self.raiseProcessLabel.text = [NSString stringWithFormat:@"%.2f%%",(float)model.raiseProcess];
    self.commissionProportionLabel.text = model.commissionProportion;
}

@end
