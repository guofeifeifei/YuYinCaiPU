//
//  MeishiViewController.m
//  CaiPu
//
//  Created by ZZCN77 on 2017/6/12.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import "MeishiViewController.h"
#import "ClassCollectionViewCell.h"
#import "AFViewController.h"
#import "ListViewController.h"
@interface MeishiViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *dateArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@end
static NSString *cellID = @"cellID";

@implementation MeishiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"菜谱分类";
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageArray = @[@"classify_1", @"classify_2", @"classify_3", @"classify_4", @"classify_5", @"classify_6", @"classify_7", @"classify_8"];
    self.titleArray = @[@"中餐", @"西餐", @"烘焙", @"食疗", @"主食", @"煲汤", @"素菜", @"荤菜"];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[ClassCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self loadNewData];

}
- (void)loadNewData{
    //进行网络判断
    if (![ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning) {
        [GFProgressHUD showMessagewithoutView:@"无网络连接" afterDelay:2];
        return;
    }
    
    [[AFNManagerRequest sharedUtil] requestGetAFURL:zhongcaiList parameters:nil succeed:^(id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *staut =[NSString stringWithFormat:@"%@", responseObject[@"res"]];
        if ([staut isEqualToString:@"2"]) {
           
            NSArray *dataArray = responseObject[@"data"];
            for (NSDictionary *dic in dataArray) {
                [self.dateArray addObject:dic[@"data"]];
            }
            [self.collectionView reloadData];
        }else{
            [GFProgressHUD showMessagewithoutView:@"数据请求失败,请再试" afterDelay:2];

        }
        
    } failure:^(NSError *errer) {
        [GFProgressHUD showMessagewithoutView:@"服务器异常,请再试" afterDelay:2];
    }];
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ClassCollectionViewCell *cell = (ClassCollectionViewCell *)[collectionView  dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.classImage.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.titleLable.text = self.titleArray[indexPath.row];

      cell.backgroundColor =  [UIColor whiteColor];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dateArray.count > indexPath.row) {
        if (indexPath.row < 4) {
            
        
        AFViewController *afView = [[AFViewController alloc] init];
        afView.titleStr = self.titleArray[indexPath.row];
           afView.dataArray = self.dateArray[indexPath.row];

        [self.navigationController pushViewController:afView animated:YES];
        }else{
            ListViewController *listVC = [[ListViewController alloc] init];
            listVC.classStr = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:listVC animated:YES];
        }
    
    }
  
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageArray.count ;
    
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
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 44) collectionViewLayout:fl];
        fl.sectionInset = UIEdgeInsetsMake(0, 10* widthScale, 10* widthScale, 10* widthScale);
        fl.itemSize = CGSizeMake(GFMainScreenWidth/2 - 16 * widthScale, GFMainScreenWidth/2 - 16 * widthScale );
        
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate =  self;
        self.collectionView.dataSource = self;
        
        
    }
    return _collectionView;
    
}

- (NSArray *)imageArray{
    if (_imageArray == nil) {
        
        self.imageArray = [NSArray new];
    }
    return _imageArray;
}
- (NSArray *)titleArray{
    if (_titleArray == nil) {
        self.titleArray = [NSArray new];

    }
    return _titleArray;
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
