//
//  ScreenModel.h
//  JuPai
//
//  Created by wangjiayu on 2017/1/13.
//
//

#import <Foundation/Foundation.h>
@class Items;


@interface ScreenModel : NSObject

extern NSString * const kDataSourceSectionKey;
extern NSString * const kDataSourceCellTestKey;
extern NSString * const kDataSourceCellPictureKey;

+ (NSMutableArray *)dataSource;


@property (nonatomic,strong) Items *item;
@property (nonatomic,strong) NSString *item_Title;
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSArray *items;


@end
