//
//  OtherCell.h
//  JuPai
//
//  Created by wangjiayu on 2017/1/13.
//
//

#import <UIKit/UIKit.h>
@class Items;

static NSString * const otherCellIdentifier = @"otherCellIdentifier";



@interface OtherCell : UICollectionViewCell
/** 数据模型 */
@property (nonatomic,strong)  Items *item;

@end
