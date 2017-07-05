//
//  AFViewController.h
//  CaiPu
//
//  Created by ZZCN77 on 2017/6/17.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFViewController : UITableViewController<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSString *titleStr;


@end
