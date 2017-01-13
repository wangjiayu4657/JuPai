//
//  HomeTableViewCell.h
//  JuPai
//
//  Created by wangjiayu on 2017/1/6.
//
//

#import <UIKit/UIKit.h>
@class ProductModel;

static NSString * const FixedIncomeCellReuseIdentifier = @"FixedIncomeCellReuseIdentifier";

@interface FixedIncomeCell : UITableViewCell

@property (nonatomic, strong) ProductModel *model;

@end
