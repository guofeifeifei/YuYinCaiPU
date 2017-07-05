//
//  BaseNavagationViewController.m
//  1454RedEnvelope
//
//  Created by ZZCN77 on 2016/12/8.
//  Copyright © 2016年 ZZCN77. All rights reserved.
//

#import "BaseNavagationViewController.h"

@interface BaseNavagationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavagationViewController
+ (void)initialize {
    // 设置为不透明
    [[UINavigationBar appearance] setTranslucent:NO];
    
    // 设置导航栏背景颜色
    [UINavigationBar appearance].barTintColor =  [UIColor whiteColor];
    //设置状态栏的字体颜色模式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //设置状态栏是否隐藏
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    
    // 设置导航栏标题文字颜色
    // 创建字典保存文字大小和颜色
    NSMutableDictionary * color = [NSMutableDictionary dictionary];
    color[NSForegroundColorAttributeName] = K6TextColor;
    color[NSFontAttributeName] = [UIFont systemFontOfSize:22];

    [[UINavigationBar appearance] setTitleTextAttributes:color];
    
//    // 拿到整个导航控制器的外观
//    UIBarButtonItem * item = [UIBarButtonItem appearance];
//    item.tintColor = KTextLColor;
//    // 设置字典的字体大小
//    NSMutableDictionary * atts = [NSMutableDictionary dictionary];
//    
//    atts[NSFontAttributeName] = [UIFont systemFontOfSize:19];
//    atts[NSForegroundColorAttributeName] = KTextLColor;
//    // 将字典给item
//    [item setTitleTextAttributes:atts forState:UIControlStateNormal];
    
    //设置背景图片
   
    //状态图片
    //添加状态按钮
    
    //删除1xp线
    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = self;
}
// @param viewController 刚刚push进来的子控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 如果viewController不是最早push进来的子控制器
        // 左上角
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 44, 44);
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
        
        [backButton sizeToFit];
        // 这句代码放在sizeToFit后面
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        // 隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 所有设置搞定后, 再push控制器
    [super pushViewController:viewController animated:animated];
}
- (void)back
{
    [self popViewControllerAnimated:YES];
    
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 手势何时有效 : 当导航控制器的子控制器个数 > 1就有效
    return self.childViewControllers.count > 1;
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
