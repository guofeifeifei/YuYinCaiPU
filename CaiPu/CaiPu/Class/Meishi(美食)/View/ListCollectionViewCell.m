//
//  ListCollectionViewCell.m
//  CaiPu
//
//  Created by ZZCN77 on 2017/6/13.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import "ListCollectionViewCell.h"

@implementation ListCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}
- (void)creatView{
    [self addSubview:self.btn];

    [self addSubview:self.classImage];
    [self addSubview:self.titleLable];

}
- (void)confignTwo:(ListTwoModel *)model{
    [self.classImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.img ]] placeholderImage:nil options:SDWebImageRefreshCached];
    self.titleLable.text = model.name;
//    NSLog(@"%@", model.name);
    [self.btn setTitle:model.name forState:UIControlStateNormal];
}
- (void)confign:(ListModel *)model{
    [self.classImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.img ]] placeholderImage:nil options:SDWebImageRefreshCached];
    self.titleLable.text = model.name;
//    NSLog(@"%@", model.name);
    [self.btn setTitle:model.name forState:UIControlStateNormal];
}
- (UIImageView *)classImage{
    if (_classImage == nil) {
        self.classImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10 * widthScale, self.bounds.size.width , self.bounds.size.width)];
        self.classImage.backgroundColor = UIColorFromRGB(0xd4d4d4);
        self.classImage.layer.shouldRasterize = YES;
        
        self.classImage.layer.cornerRadius = 5 * widthScale;
        self.classImage.layer.masksToBounds = YES;
    }
    return _classImage;
}
- (UILabel *)titleLable{
    if (_titleLable == nil) {
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(3 * widthScale,   self.bounds.size.width + 22 * widthScale , self.bounds.size.width - 6 * widthScale, 30 * widthScale)];
        self.titleLable.textColor = K6TextColor;
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        self.titleLable.font = [UIFont systemFontOfSize:18 * widthScale];
        self.titleLable.numberOfLines = 1;
        
    }
    return _titleLable;
}
- (UIButton *)btn{
    if (_btn == nil) {
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        [self.btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _btn;
}
@end
