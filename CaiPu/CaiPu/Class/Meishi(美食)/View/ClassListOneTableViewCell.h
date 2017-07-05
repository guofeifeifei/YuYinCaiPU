//
//  ClassListOneTableViewCell.h
//  CaiPu
//
//  Created by ZZCN77 on 2017/6/13.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AFIndexedCollectionView : UICollectionView

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
static NSString *CollectionViewCellIdentifier = @"CollectionViewCellIdentifier";


@interface ClassListOneTableViewCell : UITableViewCell
@property (nonatomic, strong) AFIndexedCollectionView *collectionView;
@property (nonatomic, assign)  NSInteger newItem;
@property (nonatomic, strong) UILabel *classLable;


- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;


@end
