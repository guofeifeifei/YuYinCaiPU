//
//  SearchViewController.m
//  CaiPu
//
//  Created by ZZCN77 on 2017/6/12.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor whiteColor];
      self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"home_backgroup.png"].CGImage);
    
    UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(GFMainScreenWidth - 588/3 * widthScale - 20 , 200 * widthScale, 588/3 * widthScale, 132/3 * widthScale)];
    titleImage.image = [UIImage imageNamed:@"frame_top_appname"];
    [self.view addSubview:titleImage];
    
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
