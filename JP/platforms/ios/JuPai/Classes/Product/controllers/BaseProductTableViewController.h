//
//  BaseProductTableViewController.h
//  JuPai
//
//  Created by wangjiayu on 2017/1/11.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,productTypes) {
    productTypes_fixed,
    productTypes_floating,
    productTypes_sun,
    productTypes_insurance
};

typedef enum {
    ProductTypeFixed = 1,
    ProductTypeFloating = 2,
    ProductTypeSun = 3,
    ProductTypeInsurance = 4
} ProductType;

@interface BaseProductTableViewController : UITableViewController

@property (nonatomic , assign) ProductType productType;


@end
