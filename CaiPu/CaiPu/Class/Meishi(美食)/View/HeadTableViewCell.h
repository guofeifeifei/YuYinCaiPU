//
//  HeadTableViewCell.h
//  CaiPu
//
//  Created by ZZCN77 on 2017/6/13.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *countLable;
@property (weak, nonatomic) IBOutlet UILabel *zhuchuLable;
@property (weak, nonatomic) IBOutlet UILabel *healthLable;
@property (weak, nonatomic) IBOutlet UIImageView *hatImage;

@end
