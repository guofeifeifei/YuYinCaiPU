//
//  MainTabBarViewController.m
//  1454RedEnvelope
//
//  Created by ZZCN77 on 2016/12/8.
//  Copyright © 2016年 ZZCN77. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "SearchViewController.h"
#import "MeishiViewController.h"
#import "SetViewController.h"
#import "BaseNavagationViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController
+ (void)initialize {
    
    // 设置为不透明
    [[UITabBar appearance] setTranslucent:NO];
    // 设置背景颜色
    [UITabBar appearance].barTintColor = [UIColor whiteColor];
    
    // 拿到整个导航控制器的外观
    UITabBarItem * item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, 1.5);
    
    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.62f green:0.62f blue:0.63f alpha:1.00f];
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChildViewControllerWithClassname:[SearchViewController description] imagename:@"frame_1_image_n" selectedimagename:@"frame_1_image_p" title:@"搜索"];
    [self addChildViewControllerWithClassname:[MeishiViewController description] imagename:@"frame_2_image_n" selectedimagename:@"frame_2_image_p" title:@"菜谱"];
//    [self addChildViewControllerWithClassname:[SetViewController description] imagename:@"frame_3_image_n" selectedimagename:@"frame_3_image_p"title:@"更多"];
    
}
// 添加子控制器
- (void)addChildViewControllerWithClassname:(NSString *)classname
                                  imagename:(NSString *)imagename
                          selectedimagename:(NSString *)selectedimagename
                                      title:(NSString *)title {
    
    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    BaseNavagationViewController *nav = [[BaseNavagationViewController alloc] initWithRootViewController:vc];
   nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imagename];
   // nav.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, -0);
   [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xAED1AE)} forState:UIControlStateSelected];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedimagename] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
