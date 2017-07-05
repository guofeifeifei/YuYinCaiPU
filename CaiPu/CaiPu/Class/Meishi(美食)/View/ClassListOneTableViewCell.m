//
//  ClassListOneTableViewCell.m
//  CaiPu
//
//  Created by ZZCN77 on 2017/6/13.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import "ClassListOneTableViewCell.h"
#import "ListCollectionViewCell.h"
@implementation AFIndexedCollectionView

@end
@implementation ClassListOneTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(140 * widthScale, 200 * widthScale);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[AFIndexedCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[ListCollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.classLable];
    return self;
    
}
- (UILabel *)classLable{
    
    if (_classLable == nil) {
        self.classLable = [[UILabel alloc] initWithFrame:CGRectMake(0,   10 * widthScale ,  40 * widthScale, 180 * widthScale)];
        self.classLable.textColor = [UIColor whiteColor];
        self.classLable.textAlignment = NSTextAlignmentCenter;
        self.classLable.font = [UIFont systemFontOfSize:20 * widthScale];
        self.classLable.numberOfLines = 0;
        self.classLable.backgroundColor = GFColor(64, 61, 58, 1);
    }
    return _classLable;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake( 40 * widthScale, 0, GFMainScreenWidth - 40 * widthScale,  200 * widthScale);
    self.collectionView.contentOffset = CGPointMake(0, 0);
    
}
- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath
{
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.indexPath = indexPath;
    [self.collectionView setContentOffset:self.collectionView.contentOffset animated:NO];
    
    [self.collectionView reloadData];
}


@end
