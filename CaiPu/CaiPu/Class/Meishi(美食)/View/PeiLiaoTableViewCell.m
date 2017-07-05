//
//  PeiLiaoTableViewCell.m
//  CaiPu
//
//  Created by ZZCN77 on 2017/6/13.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import "PeiLiaoTableViewCell.h"

@implementation PeiLiaoTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
    
}
- (void)creatView{
    [self.contentView addSubview:self.contentLable];
    [self.contentView addSubview:self.nameLable];
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.nameLongLable];
}
- (void)configUI:(BurdenModel *)model{
    self.contentLable.text = model.content;
    self.nameLable.text =  model.name;
//    self.nameLongLable.text =  model.name;

}
- (UILabel *)contentLable{
    if (_contentLable == nil) {
        self.contentLable = [[UILabel alloc] initWithFrame:CGRectMake((GFMainScreenWidth )/2 + 15 * widthScale,   0 * widthScale , (GFMainScreenWidth )/2 - 15 * widthScale, 30 * widthScale)];
        self.contentLable.textColor = K6TextColor;
        self.contentLable.textAlignment = NSTextAlignmentLeft;
        self.contentLable.font = [UIFont systemFontOfSize:15 * widthScale];
        self.contentLable.numberOfLines = 1;
    }
    return _contentLable;
}

- (UILabel *)nameLable{
    if (_nameLable == nil) {
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0,   0 * widthScale , (GFMainScreenWidth )/2 - 15 * widthScale, 30 * widthScale)];
        self.nameLable.textColor = GFColor(145, 15, 6, 1);
        self.nameLable.textAlignment = NSTextAlignmentRight;
        self.nameLable.font = [UIFont systemFontOfSize:15 * widthScale];
        self.nameLable.numberOfLines = 2;
        
  
    }
    return _nameLable;
}
- (UILabel *)nameLongLable{
    if (_nameLongLable == nil) {
        self.nameLongLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, GFMainScreenWidth, 30 * widthScale)];
        self.nameLongLable.textColor = GFColor(145, 15, 6, 1);
        self.nameLongLable.textAlignment = NSTextAlignmentRight;
        self.nameLongLable.font = [UIFont systemFontOfSize:15 * widthScale];
        self.nameLongLable.numberOfLines = 1;
    }
    return _nameLongLable;
}
- (UILabel *)titleLable{
    if (_titleLable == nil) {
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, GFMainScreenWidth, 30 * widthScale)];
        self.titleLable.textColor = GFColor(145, 15, 6, 1);
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        self.titleLable.font = [UIFont systemFontOfSize:15 * widthScale];
        self.titleLable.numberOfLines = 1;

    }
    return _titleLable;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
