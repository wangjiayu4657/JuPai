//
//  ScreenModel.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/13.
//
//

#import "ScreenModel.h"
#import "MJExtension.h"
#import "Items.h"

NSString * const kDataSourceSectionKey       = @"Items";
NSString * const kDataSourceCellTestKey      = @"Item_Title";
NSString * const kDataSourceCellPictureKey   = @"Picture";

@implementation ScreenModel


+(NSMutableArray *)dataSource {
    static NSMutableArray *dataSource;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataSource = [NSMutableArray array];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data.json" ofType:nil];
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:filePath];
        NSError *error;
        if (data) {
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            [arr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ScreenModel *model = [[ScreenModel alloc] init];
                model.type = obj[@"type"];
                model.items = [Items mj_objectArrayWithKeyValuesArray:obj[@"items"]];
                [dataSource addObject:model];
            }];
        }
    });
    return dataSource;
}

@end
