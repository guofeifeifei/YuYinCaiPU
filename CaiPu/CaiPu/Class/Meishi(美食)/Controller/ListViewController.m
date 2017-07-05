//
//  ListViewController.m
//  CaiPu
//
//  Created by ZZCN77 on 2017/6/13.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import "ListViewController.h"
#import "ListCollectionViewCell.h"
#import "ListTwoModel.h"
#import "DetailViewController.h"
@interface ListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@end
static NSString *cellID = @"cellID";

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.title = self.classStr;
    self.view.backgroundColor = KfColor;
    self.page = 1;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[ListCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self loadNewData];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self loadNewData];
    }];
}
- (void)loadNewData{
    //进行网络判断
    if (![ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning) {
        [GFProgressHUD showMessagewithoutView:@"无网络连接" afterDelay:2];
        return;
    }

    NSString *str = [NSString stringWithFormat:@"%@s=%@&page=%ld", caiList, [self.classStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]], (long)self.page];
    NSLog(@"%@", str);
    [[AFNManagerRequest sharedUtil] requestGetAFURL:str parameters:nil succeed:^(id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *staut =[NSString stringWithFormat:@"%@", responseObject[@"res"]];
        if ([staut isEqualToString:@"2"]) {
            NSArray *dataArray = responseObject[@"data"];
            for (NSDictionary *dic in dataArray) {
                ListTwoModel *model = [[ListTwoModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dateArray addObject:model];
            }
            [self.collectionView reloadData];
        }else{
            [GFProgressHUD showMessagewithoutView:@"数据请求失败,请再试" afterDelay:2];
            
        }
        
    } failure:^(NSError *errer) {
        [GFProgressHUD showMessagewithoutView:@"数据请求失败,请再试" afterDelay:2];
        
    }];
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ListCollectionViewCell *cell = (ListCollectionViewCell *)[collectionView  dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (self.dateArray.count > indexPath.row) {
        [cell confignTwo:self.dateArray[indexPath.row]];
        
    }
    cell.btn.enabled = NO;
    cell.backgroundColor =  [UIColor whiteColor];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dateArray.count > indexPath.row) {
        
        ListTwoModel *model = self.dateArray[indexPath.row];
        DetailViewController *detailVC =[[DetailViewController alloc] init];
        detailVC.codeStr = model.code;
        detailVC.titleStr = model.name;

        [self.navigationController pushViewController:detailVC animated:YES];
        
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dateArray.count ;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10 * widthScale;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10 * widthScale;
    
}
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
        fl.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64) collectionViewLayout:fl];
        fl.sectionInset = UIEdgeInsetsMake(0, 10* widthScale, 10* widthScale, 10* widthScale);
        fl.itemSize = CGSizeMake(GFMainScreenWidth/2 - 16 * widthScale, GFMainScreenWidth/2 + 30 * widthScale );
        
        self.collectionView.backgroundColor = KfColor;
        self.collectionView.delegate =  self;
        self.collectionView.dataSource = self;
        
        
    }
    return _collectionView;
    
}


- (NSMutableArray *)dateArray{
    if (_dateArray == nil) {
        self.dateArray = [[NSMutableArray alloc] init];
    }
    return _dateArray;
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
