//
//  SunlightPrivateCell.h
//  JuPai
//
//  Created by wangjiayu on 2017/1/9.
//
//

#import <UIKit/UIKit.h>
@class ProductModel;
static NSString * const SunlightPrivateCellReuseIdentifier = @"SunlightPrivateCellReuseIdentifier";

@interface SunlightPrivateCell : UITableViewCell

@property (nonatomic, strong) ProductModel *model;

@end
