//
//  HeaderView.h
//  JuPai
//
//  Created by wangjiayu on 2017/1/13.
//
//

#import <UIKit/UIKit.h>
@class ScreenModel;

static NSString * const headerViewCellIdentifier = @"headerViewCellIdentifier";

@interface HeaderView : UICollectionViewCell
/** 模型 */
@property (nonatomic,strong) ScreenModel *model;

@end
