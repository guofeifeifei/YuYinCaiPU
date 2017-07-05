//
//  GFProgressHUD.h
//  DaGuanYun
//
//  Created by ZZCN77 on 16/10/21.
//  Copyright © 2016年 ZZCN77. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>
@interface GFProgressHUD : NSObject
@property (nonatomic,strong) MBProgressHUD  *hud;


+ (instancetype)sharedinstance;
+(void)showMessagewithoutView:(NSString *)msg afterDelay:(NSTimeInterval)time;
//显示
+(void)show:(NSString *)msg inView:(UIView *)view;
+ (void)showChrysanthemumView;
+ (void)hideChrysanthemumView;
@end
