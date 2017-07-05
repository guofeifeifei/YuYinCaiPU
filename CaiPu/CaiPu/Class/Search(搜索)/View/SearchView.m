//
//  SearchView.m
//  CaiPu
//
//  Created by ZZCN77 on 2017/7/5.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self CreatView];
    }
    return self;
}
- (void)CreatView{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10.0;
    [self addSubview:self.statusLable];
    [self addSubview:self.searchBtn];
    
    
}
- (UILabel *)statusLable{
    if (_statusLable == nil) {
        self.statusLable = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.height + 10, 0, self.frame.size.width - (self.frame.size.height + 10), self.frame.size.height)];
        self.statusLable.text = @"请输入要输入的内容";
        self.statusLable.textColor = [UIColor grayColor];
        self.statusLable.textAlignment = NSTextAlignmentLeft;
        self.statusLable.font =[UIFont systemFontOfSize:15];
    }
    return _statusLable;
}
- (UIButton *)searchBtn{
    if (_searchBtn == nil) {
        self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.searchBtn.frame = CGRectMake(10, 0, self.frame.size.height, self.frame.size.height);
        [self.searchBtn setImage:[UIImage imageNamed:@"i_ico_search"] forState:UIControlStateNormal];
        
    }
    return _searchBtn;
}
@end
