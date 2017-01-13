//
//  ProductModel.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/9.
//
//

#import "ProductModel.h"

@implementation ProductModel

-(CGFloat) rowHeight {
    switch (_productType) {
        case 1:
            return 150;
            break;
            
        case 2:
            return 150;
            break;
            
        case 3:
            return 125;
            break;
            
        case 4:
            return 140;
            break;
            
        default:
            break;
    }
    return 0;
}

- (NSString *)wanInvestAmount {
    return [NSString stringWithFormat:@"%zd 万元",_minInvestAmount / 10000];
}

//- (NSMutableArray *)contentArray {
//    if (!_contentArray) {
//        _contentArray = [NSMutableArray array];
//    }
//    return _contentArray;
//}


@end
