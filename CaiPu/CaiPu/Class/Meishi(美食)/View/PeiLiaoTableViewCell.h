//
//  PeiLiaoTableViewCell.h
//  CaiPu
//
//  Created by ZZCN77 on 2017/6/13.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BurdenModel.h"
@interface PeiLiaoTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic, strong) UILabel *contentLable;
- (void)configUI:(BurdenModel *)model;
@property (nonatomic, strong) UILabel *nameLongLable;
@property (nonatomic, strong) UILabel *titleLable;

@end
