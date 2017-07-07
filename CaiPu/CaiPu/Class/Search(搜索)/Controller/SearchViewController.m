//
//  SearchViewController.m
//  CaiPu
//
//  Created by ZZCN77 on 2017/6/12.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchView.h"
#import "AlertView.h"
#import "SearchListViewController.h"
@interface SearchViewController (){
    AlertView *_alertView;
}
@property (nonatomic, strong) NSDictionary *alertDic;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"home_backgroup.png"].CGImage);
    [self loadData];
    //标题图片
    UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(GFMainScreenWidth - 588/3 * widthScale - 20 , 200 * widthScale, 588/3 * widthScale, 132/3 * widthScale)];
    titleImage.image = [UIImage imageNamed:@"frame_top_appname"];
    [self.view addSubview:titleImage];
    
    //搜索框
    SearchView *searchView = [[SearchView alloc] initWithFrame:CGRectMake(20, 300, GFMainScreenWidth - 40, 40 * widthScale)];
    
    //提示框
    _alertView = [[AlertView alloc] initWithFrame:CGRectMake(20, 330, GFMainScreenWidth - 40, 80 * widthScale)];
    [self.view addSubview:_alertView];
    [self.view addSubview:searchView];

    UIButton *alertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    alertBtn.frame = self.view.bounds;
    [alertBtn addTarget:self action:@selector(alertAction:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:alertBtn];
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = self.view.bounds;
    [searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:searchBtn];
    
}
- (void)alertAction:(UIButton *)btn{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://m.xiangha.com/zhishi/%@", self.alertDic[@"code"]]] options:@{} completionHandler:^(BOOL success) {
        
    }];
    
}
- (void)searchAction:(UIButton *)btn{
    SearchListViewController *searchVC = [[SearchListViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    
}
- (void)loadData{
    //进行网络判断
    if (![ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning) {
        [GFProgressHUD showMessagewithoutView:@"无网络连接" afterDelay:2];
        return;
    }
    
    [[AFNManagerRequest sharedUtil] requestGetAFURL:@"http://api.xiangha.com/category/home/getNous?" parameters:nil succeed:^(id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *staut =[NSString stringWithFormat:@"%@", responseObject[@"res"]];
        if ([staut isEqualToString:@"2"]) {
            NSArray *data = responseObject[@"data"];
            self.alertDic = data[0];
            _alertView.titleLable.text = self.alertDic[@"classifyname"];
            _alertView.detailLable.text = self.alertDic[@"title"];
            [_alertView.imgView sd_setImageWithURL:[NSURL URLWithString:self.alertDic[@"img"]]];
                }else{
            [GFProgressHUD showMessagewithoutView:@"数据请求失败,请再试" afterDelay:2];
            
        }
        
    } failure:^(NSError *errer) {
        [GFProgressHUD showMessagewithoutView:@"数据请求失败,请再试" afterDelay:2];
    }];
    
    
    
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
