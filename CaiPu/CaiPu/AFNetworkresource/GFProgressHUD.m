//
//  GFProgressHUD.m
//  DaGuanYun
//
//  Created by ZZCN77 on 16/10/21.
//  Copyright © 2016年 ZZCN77. All rights reserved.
//

#import "GFProgressHUD.h"

@implementation GFProgressHUD
+ (instancetype)sharedinstance{
    static GFProgressHUD *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GFProgressHUD alloc] init];
        
    });
       return instance;
    
}
+(void)showMessagewithoutView:(NSString *)msg afterDelay:(NSTimeInterval)time{
    UIWindow *view = [[UIApplication sharedApplication].windows lastObject];
    [self show:msg inView:view];
    [[GFProgressHUD sharedinstance].hud hideAnimated:YES afterDelay:time];
    
}
+(void)show:(NSString *)msg inView:(UIView *)view {
    //如果已有弹框，先消失
    if ([GFProgressHUD sharedinstance].hud != nil) {
        [[GFProgressHUD sharedinstance].hud hideAnimated:YES];
        [GFProgressHUD sharedinstance].hud = nil;
    }
    
    //4\4s屏幕避免键盘存在时遮挡
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [view endEditing:YES];
    }
    
    [GFProgressHUD sharedinstance].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [GFProgressHUD sharedinstance].hud.margin = 15.0f;
    [GFProgressHUD sharedinstance].hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    [GFProgressHUD sharedinstance].hud.bezelView.color = [UIColor blackColor];
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [GFProgressHUD sharedinstance].hud.yOffset = 200.0f * heightScale;
        
    }
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        [GFProgressHUD sharedinstance].hud.yOffset = 230.0f * heightScale;
    }else{
        
        [GFProgressHUD sharedinstance].hud.yOffset = 250.0f * heightScale;
    }
    [GFProgressHUD sharedinstance].hud.userInteractionEnabled = NO;
    
    [GFProgressHUD sharedinstance].hud.backgroundColor = [UIColor clearColor];
    [[GFProgressHUD sharedinstance].hud setMargin:10 * widthScale];
    [[GFProgressHUD sharedinstance].hud setRemoveFromSuperViewOnHide:YES];
    [GFProgressHUD sharedinstance].hud.detailsLabel.text = msg;
    [GFProgressHUD sharedinstance].hud.contentColor = [UIColor whiteColor];
    [GFProgressHUD sharedinstance].hud.detailsLabel.font = [UIFont systemFontOfSize:18 * widthScale];
    [GFProgressHUD sharedinstance].hud.mode = MBProgressHUDModeText;
    
}
+ (void)showChrysanthemumView{
    UIWindow *view = [[UIApplication sharedApplication].windows lastObject];
    //如果已有弹框，先消失
    if ([GFProgressHUD sharedinstance].hud != nil) {
        [[GFProgressHUD sharedinstance].hud hideAnimated:YES];
        [GFProgressHUD sharedinstance].hud = nil;
    }
    
    [GFProgressHUD sharedinstance].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [GFProgressHUD sharedinstance].hud.margin = 15.0f;
    [GFProgressHUD sharedinstance].hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    [GFProgressHUD sharedinstance].hud.bezelView.color = [UIColor blackColor];
    [GFProgressHUD sharedinstance].hud.backgroundColor = [UIColor clearColor];
    [[GFProgressHUD sharedinstance].hud setMargin:10 * widthScale];
    [[GFProgressHUD sharedinstance].hud setRemoveFromSuperViewOnHide:YES];
    [GFProgressHUD sharedinstance].hud.detailsLabel.text = @"Loading";
    [GFProgressHUD sharedinstance].hud.contentColor = [UIColor whiteColor];
    [GFProgressHUD sharedinstance].hud.detailsLabel.font = [UIFont systemFontOfSize:18 * widthScale];
    [GFProgressHUD sharedinstance].hud.mode = MBProgressHUDModeIndeterminate;
    
    [GFProgressHUD sharedinstance].hud.userInteractionEnabled = NO;



}
+ (void)hideChrysanthemumView{
     [[GFProgressHUD sharedinstance].hud hideAnimated:YES];
}
@end
