//
//  MarkTableViewCell.h
//  CaiPu
//
//  Created by ZZCN77 on 2017/6/13.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarkModel.h"
@interface MarkTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *makeImageView;
@property (nonatomic, strong) UILabel *contentLable;

- (void)configUI:(MarkModel *)model;
//定义一个类，在外部调用，通过传入model参数，计算出来每一个cell高度
+ (CGFloat)getCellHeightWidthMangoModel:(MarkModel *)markModle;

@end
