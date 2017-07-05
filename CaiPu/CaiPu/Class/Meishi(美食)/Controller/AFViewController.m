//
//  AFViewController.m
//  CaiPu
//
//  Created by ZZCN77 on 2017/6/17.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import "AFViewController.h"
#import "ClassListOneTableViewCell.h"
#import "ListCollectionViewCell.h"
#import "ListModel.h"
#import "ListViewController.h"

@interface AFViewController ()

@property (nonatomic, strong) NSMutableArray *listClassArray;
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
@end
static NSString *cellIdentifier = @"cellIdentifier";

@implementation AFViewController

-(void)loadView
{
    [super loadView];
    

    self.listClassArray = [NSMutableArray new];

    for (NSDictionary *dicItem  in self.dataArray) {
        NSArray *array = dicItem[@"data"];

        NSMutableArray *arraylist = [NSMutableArray new];
        for ( NSDictionary *dic in array) {
            ListModel *model = [[ListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            
            [arraylist addObject:model];
        }
        
        [self.listClassArray addObject:arraylist];
    }
    self.contentOffsetDictionary = [NSMutableDictionary dictionary];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.title = self.titleStr;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listClassArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassListOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ClassListOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
   
    cell.classLable.text = self.dataArray[indexPath.row][@"name"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(ClassListOneTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
    NSInteger index = cell.collectionView.indexPath.row;
    CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
    [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
}

#pragma mark - UITableViewDelegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200 * widthScale;
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *collectionViewArray = self.listClassArray[[(AFIndexedCollectionView *)collectionView indexPath].row];
    return collectionViewArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];

    
    NSArray *collectionViewArray = self.listClassArray[[(AFIndexedCollectionView *)collectionView indexPath].row];
    if (collectionViewArray.count > indexPath.item) {
        [cell confign:collectionViewArray[indexPath.item]];
    }
    [cell.btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)clickAction:(UIButton *)btn{
    ListViewController *listVC = [[ListViewController alloc] init];
    listVC.classStr = btn.titleLabel.text;
    [self.navigationController pushViewController:listVC animated:YES];
    
}
#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UICollectionView class]]) return;
    
    CGFloat horizontalOffset = scrollView.contentOffset.x;
    
    AFIndexedCollectionView *collectionView = (AFIndexedCollectionView *)scrollView;
    NSInteger index = collectionView.indexPath.row;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}


@end
