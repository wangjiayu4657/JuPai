//
//  ProductModel.h
//  JuPai
//
//  Created by wangjiayu on 2017/1/9.
//
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject

/**
 appointAmount = 7500000;
 balance = 0;
 categoryName = "\U503a\U5238\U578b";
 commissionProportion = "\U4f63\U91d1\U5f85\U5b9a";
 display = 1;
 expect = "0%";
 fullName = "YG2016122701\U503a\U5377\U4eba\U6c11\U5e01120qc\U4ea7\U54c1\U4e00qc";
 id = 1003637;
 issueAmount = 0;
 issueQuota = 0;
 limit = "\U6c38\U7eed";
 maxExpectValue = "0%";
 minInvestAmount = 2000000;
 name = "YG2016122701\U503a\U5377\U4eba\U6c11\U5e01120\U4ea7\U54c1\U4e00";
 process = 0;
 productType = 3;
 projectCategoryDictId = 301;
 raiseCurrency = "\U4eba\U6c11\U5e01";
 raiseCurrencyAlias = "\U5143";
 raiseProcess = 0;
 shortageStatus = 0;
 statusVal = 1;
 subscribeAmount = 7500000;
 title = "YG2016122701\U503a\U5377\U4eba\U6c11\U5e01120\U4ea7\U54c1\U4e00";
 */

///预约金额
//@property (nonatomic,assign) NSInteger appointAmount;
///余额
//@property (nonatomic,assign) NSInteger balance;
///是否可见
//@property (nonatomic,assign) NSInteger display;
///
@property (nonatomic,assign) NSInteger id;
///发行金额
@property (nonatomic,assign) NSInteger issueAmount;
///发行额度
@property (nonatomic,assign) NSInteger issueQuota;
///起投金额
@property (nonatomic,assign) NSInteger minInvestAmount;
///产品类型
@property (nonatomic,assign) NSInteger productType;
///产品小类 ID
//@property (nonatomic,assign) NSInteger projectCategoryDictId;
///预约进度
//@property (nonatomic,assign) NSInteger process;
///募集进度
@property (nonatomic,assign) NSInteger raiseProcess;
///紧张标签
@property (nonatomic,assign) NSInteger shortageStatus;
///产品状态值
@property (nonatomic,assign) NSInteger statusVal;
///申购金额
//@property (nonatomic,assign) NSInteger subscribeAmount;

///产品小类
@property (nonatomic,strong) NSString *categoryName;
///佣金比例
@property (nonatomic,strong) NSString *commissionProportion;
///预计年化收益率
@property (nonatomic,strong) NSString *expect;
///产品全称
//@property (nonatomic,strong) NSString *fullName;
///投资期限
@property (nonatomic,strong) NSString *limit;
///最大收益值
@property (nonatomic,strong) NSString *maxExpectValue;
///产品简称
//@property (nonatomic,strong) NSString *name;
///募集币种
@property (nonatomic,strong) NSString *raiseCurrency;
///募集币种单位
@property (nonatomic,strong) NSString *raiseCurrencyAlias;
///产品名称
@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSString *wanInvestAmount;

///页码
@property (nonatomic,assign) NSInteger pageIndex;
///每页的个数
@property (nonatomic,assign) NSInteger pageSize;
///总页数
@property (nonatomic,assign) NSInteger totalPageCount;
///总行数
@property (nonatomic,assign) NSInteger totalRowCount;

@property (nonatomic,assign) NSInteger totalCount;
///当前页
//@property (nonatomic,assign) NSInteger currentPage;totalCount

//@property (nonatomic,strong) NSMutableArray *contentArray;

- (CGFloat) rowHeight;


   
@end
