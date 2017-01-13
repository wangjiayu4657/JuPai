//
//  InsuranceTableViewCell.h
//  JuPai
//
//  Created by wangjiayu on 2017/1/9.
//
//

#import <UIKit/UIKit.h>
@class ProductModel;
static NSString * const InsuranceTableViewCellReuseIdentifier = @"InsuranceTableViewCellReuseIdentifier";

@interface InsuranceTableViewCell : UITableViewCell

@property (nonatomic, strong) ProductModel *model;

@end
