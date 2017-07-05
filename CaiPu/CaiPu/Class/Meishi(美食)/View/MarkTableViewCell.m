//
//  MarkTableViewCell.m
//  CaiPu
//
//  Created by ZZCN77 on 2017/6/13.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import "MarkTableViewCell.h"

@implementation MarkTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;

}

- (void)creatView{
    [self addSubview:self.makeImageView];
    [self addSubview:self.contentLable];

}

- (void)configUI:(MarkModel *)model{
    
    self.contentLable.text = [NSString stringWithFormat:@"%@.%@", model.num,model.info];
    [self.makeImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil options:SDWebImageRefreshCached];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.img]]];
    CGFloat textHeight = [[self class] getTextHeightWithText:model.info];

    self.contentLable.frame = CGRectMake(20 * widthScale, 0, GFMainScreenWidth - 40 * widthScale, textHeight);
    self.makeImageView.frame = CGRectMake(40 * widthScale, textHeight + 20 * widthScale, GFMainScreenWidth - 80 * widthScale, (GFMainScreenWidth - 80 * widthScale)/image.size.width * image.size.height);
}
- (UILabel *)contentLable{
    if (_contentLable == nil) {
        self.contentLable = [[UILabel alloc] initWithFrame:CGRectMake(20 * widthScale, 20 * widthScale, GFMainScreenWidth - 40 * widthScale, 20 * widthScale)];
        self.contentLable.textColor = [UIColor blackColor];
        self.contentLable.textAlignment = NSTextAlignmentLeft;
        self.contentLable.font = [UIFont systemFontOfSize:15 * widthScale];
        self.contentLable.numberOfLines = 0;
    }
    return _contentLable;
}
- (UIImageView *)makeImageView{
    if (_makeImageView == nil) {
        self.makeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, GFMainScreenWidth, 100 * widthScale)];

    }
    return _makeImageView;
}

//根据文本的内容获取文本的高度
+ (CGFloat)getTextHeightWithText:(NSString *)carIntroduce{
    //计算文本高度的方法
    //boundingRectWithSize当获取指定文字高度的时候需要一个CGSize类型的参数， 需要让文字在这个限定的高度和宽度区域内显示，通常高度和你要显示的lable的狂赌保持一致，高度尽可能的设置高一点
    //options:实现现实的方式
    //attributes：设置文字相关的一些属性,当设置文字字体大小的时候需要跟要显示的Lable字体大小保持一致
    //context:文本绘制的上下文，一本不需要设置，直接写nil
    CGRect textRect = [carIntroduce boundingRectWithSize:CGSizeMake(GFMainScreenWidth - 60 * widthScale, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0 * widthScale]} context:nil];
    
    return textRect.size.height;
    
}
+ (CGFloat)getCellHeightWidthMangoModel:(MarkModel *)markModle{
    //定义一个类，在外部调用，通过传入model参数，计算出来每一个cell高度
    CGFloat textHeight = [[self class] getTextHeightWithText:markModle.info];

    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:markModle.img]]];
    //车名Lable高度+品牌介绍Lable高度
    return textHeight + ((GFMainScreenWidth - 80 * widthScale)/image.size.width * image.size.height ) + 40 * widthScale;

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
