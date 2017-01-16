//
//  SortViewCell.h
//  JuPai
//
//  Created by wangjiayu on 2017/1/13.
//
//

#import <UIKit/UIKit.h>
@class Items;

static NSString * const sortViewCellIdentifier = @"sortViewCellIdentifier";



@interface SortViewCell : UICollectionViewCell
/** 数据模型 */
@property (nonatomic,strong)  Items *items;

@property (weak, nonatomic) IBOutlet UIView *lineView;


@end
