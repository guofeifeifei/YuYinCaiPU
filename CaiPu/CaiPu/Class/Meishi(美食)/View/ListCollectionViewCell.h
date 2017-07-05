//
//  ListCollectionViewCell.h
//  CaiPu
//
//  Created by ZZCN77 on 2017/6/13.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"
#import "ListTwoModel.h"
@interface ListCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *classImage;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIButton *btn;

- (void)confign:(ListModel *)model;
- (void)confignTwo:(ListTwoModel *)model;

@end
