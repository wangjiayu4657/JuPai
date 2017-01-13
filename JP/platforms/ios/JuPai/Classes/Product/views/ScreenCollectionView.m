//
//  ScreenCollectionView.m
//  JuPai
//
//  Created by wangjiayu on 2017/1/13.
//
//

#import "ScreenCollectionView.h"
#import "UIView+WJYExtension.h"
#import "ScreenModel.h"
#import "Items.h"
#import "SortViewCell.h"
#import "OtherCell.h"
#import "HeaderView.h"

///间距
#define margin 10
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height


@interface ScreenCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

/** collectionView */
@property (nonatomic,weak) UICollectionView *collectionView;
/** 数据模型 */
@property (nonatomic,weak) ScreenModel *model;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ScreenCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = [ScreenModel dataSource];
        [self setupCollectionView];
        [self.collectionView reloadData];
    }
    return self;
}

///懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

///初始化 collectionView
- (void)setupCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, Height - 60.0) collectionViewLayout:flowLayout];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SortViewCell class]) bundle:nil] forCellWithReuseIdentifier:sortViewCellIdentifier];
    [collectionView registerClass:[OtherCell class] forCellWithReuseIdentifier:otherCellIdentifier];
    [collectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewCellIdentifier];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView reloadData];
    [self addSubview:collectionView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelButton.frame = CGRectMake(0, self.height - 110, self.width / 2, 60);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:20];
    cancelButton.backgroundColor = [UIColor whiteColor];
    cancelButton.layer.borderWidth = 1.0;
    cancelButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview: cancelButton];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sureButton.frame = CGRectMake(self.width / 2, self.height - 110, self.width / 2, 60);
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    sureButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    sureButton.titleLabel.font = [UIFont systemFontOfSize:20];
    sureButton.backgroundColor = [UIColor whiteColor];
    sureButton.layer.borderWidth = 1.0;
    sureButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self addSubview: sureButton];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ScreenModel *model = self.dataArray[section];
    return model.items.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.width, 35);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        return CGSizeMake((self.width - 2 * (margin + 1)) / 2, 35);
    } else {
        return CGSizeMake((self.width - 4 * margin) / 3, 35);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(margin / 2, margin, margin / 2, margin);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return margin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    }
    return margin;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    ScreenModel *model = self.dataArray[indexPath.section];
    model.item = model.items[indexPath.item];
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        SortViewCell *sortCell = [collectionView dequeueReusableCellWithReuseIdentifier:sortViewCellIdentifier forIndexPath:indexPath];
        sortCell.lineView.hidden = (indexPath.item != 0);
        sortCell.item = model.item;
        cell = sortCell;
    } else {
        OtherCell *otherCell = [collectionView dequeueReusableCellWithReuseIdentifier:otherCellIdentifier forIndexPath:indexPath];
        otherCell.item = model.item;
        cell = otherCell;
    }
   
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ScreenModel *model = self.dataArray[indexPath.item];
    HeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewCellIdentifier forIndexPath:indexPath];
//    view.backgroundColor = [UIColor blueColor];
    view.model = model;
    return view;
}

@end
