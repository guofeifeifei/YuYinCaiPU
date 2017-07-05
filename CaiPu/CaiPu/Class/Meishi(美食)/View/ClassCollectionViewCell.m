//
//  ClassCollectionViewCell.m
//  jiankong
//
//  Created by ZZCN77 on 2017/5/20.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import "ClassCollectionViewCell.h"
@implementation ClassCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}
- (void)creatView{
    [self addSubview:self.classImage];
    [self addSubview:self.titleLable];
    
}

- (UIImageView *)classImage{
    if (_classImage == nil) {
        self.classImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10 * widthScale, self.bounds.size.width , self.bounds.size.width)];
        self.classImage.backgroundColor = UIColorFromRGB(0xd4d4d4);
        self.classImage.layer.shouldRasterize = YES;

        self.classImage.layer.cornerRadius = 15 * widthScale;
        self.classImage.layer.masksToBounds = YES;
    }
    return _classImage;
}
- (UILabel *)titleLable{
    if (_titleLable == nil) {
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(3 * widthScale,   self.bounds.size.width - 22 * widthScale , self.bounds.size.width - 6 * widthScale, 30 * widthScale)];
        self.titleLable.textColor = [UIColor whiteColor];
        self.titleLable.textAlignment = NSTextAlignmentCenter;

        self.titleLable.font = [UIFont systemFontOfSize:20 * widthScale];
        self.titleLable.numberOfLines = 1;
        
    }
    return _titleLable;
}

@end
