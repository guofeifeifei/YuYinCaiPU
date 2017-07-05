
//
//  AlertView.m
//  CaiPu
//
//  Created by ZZCN77 on 2017/7/5.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}
- (void)creatView{
    self.layer.cornerRadius = 10;
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5f];

    [self addSubview:self.titleLable];
    [self addSubview:self.detailLable];
    [self addSubview:self.imgView];
    
    
    
}
- (UILabel *)titleLable{
    if (_titleLable == nil) {
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 25, self.frame.size.width - (20), 20)];
        self.titleLable.text = @"请输入要输入的内容";
        self.titleLable.textColor = [UIColor whiteColor];
        self.titleLable.textAlignment = NSTextAlignmentLeft;
        self.titleLable.font =[UIFont systemFontOfSize:15];
 
    }
    return _titleLable;
}
- (UILabel *)detailLable{
    if (_detailLable == nil) {
        self.detailLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 55, self.frame.size.width - (20), 20)];
        self.detailLable.text = @"请输入要输入的内容";
        self.detailLable.textColor = [UIColor whiteColor];
        self.detailLable.textAlignment = NSTextAlignmentLeft;
        self.detailLable.font =[UIFont systemFontOfSize:14];
  
    }
    return _detailLable;
}
- (UIImageView *)imgView{
    if (_imgView == nil) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 70, 25, 50, 50)];
        self.imgView.image = [UIImage imageNamed:@"classify_7.png"];
        CAShapeLayer *layer = [CAShapeLayer layer];
        UIBezierPath *aPath = [UIBezierPath bezierPathWithRoundedRect:self.imgView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(25 , 25 )];
        layer.path = aPath.CGPath;
        self.imgView.layer.mask = layer;
        self.imgView.layer.masksToBounds = YES;

    }
    return _imgView;
}
@end
