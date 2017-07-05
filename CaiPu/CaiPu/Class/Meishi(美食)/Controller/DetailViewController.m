//
//  DetailViewController.m
//  CaiPu
//
//  Created by ZZCN77 on 2017/6/13.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import "DetailViewController.h"
#import "HeadTableViewCell.h"
#import "PeiLiaoTableViewCell.h"
#import "MarkTableViewCell.h"
#import "BurdenModel.h"
#import "MarkModel.h"
#import <Lottie/Lottie.h>
#import "BDSSpeechSynthesizerDelegate.h"
#import "BDSSpeechSynthesizer.h"

@interface DetailViewController ()<UITableViewDataSource, UITableViewDelegate, BDSSpeechSynthesizerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *makesArray;
@property (nonatomic, strong) NSMutableArray *burdenArray;
@property (nonatomic, strong) LOTAnimationView *animationView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIImageView *bgImageView;

@end
static NSString *cellIdentifier = @"cellIdentifier1";
static NSString *cellIdentifier2 = @"cellIdentifier2";

static NSString *cellIdentifier3 = @"cellIdentifier3";

@implementation DetailViewController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.bgImageView removeFromSuperview];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.title = self.titleStr;
    self.view.backgroundColor = [UIColor whiteColor];
    [self headViewCreat];
    [self loadData];
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"HeadTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.tableView];
    
    self.animationView = [LOTAnimationView  animationNamed:@"empty_status.json"];
    self.animationView.frame = CGRectMake(0, 0, GFMainScreenWidth, GFMainScreenWidth);
    self.animationView.center = self.view.center;
    self.animationView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.animationView];
    self.animationView.loopAnimation = true;
    [self.animationView play];
    
    
    //语音合成
    [[BDSSpeechSynthesizer sharedInstance] setSynthesizerDelegate:self];
    [[BDSSpeechSynthesizer sharedInstance] setApiKey:@"" withSecretKey:@""];
    //设置离线引擎
    NSString *ChineseSpeechData = [[NSBundle mainBundle] pathForResource:@"Chinese_Speech_Female" ofType:@"dat"];
    
    NSString *ChineseTextData = [[NSBundle mainBundle] pathForResource:@"Chinese_text" ofType:@"dat"];
    NSString *EnglishSpeechData = [[NSBundle mainBundle] pathForResource:@"English_Speech_Female" ofType:@"dat"];
    NSString *EnglishTextData = [[NSBundle mainBundle] pathForResource:@"English_text" ofType:@"dat"];
    NSString *LicenseData = [[NSBundle mainBundle] pathForResource:@"bdtts_license" ofType:@"dat"];
//    NSError *loadErr = [[BDSSpeechSynthesizer sharedInstance] startTTSEngine:ChineseTextData                                    speechDataPath:ChineseSpeechData
//                                                             licenseFilePath:LicenseData withAppCode:@""];
//    
//    if(loadErr != nil)
//    {
//        // 处理出错状况
//    }
//    
//    // 加载英文资源
//    loadErr = [[BDSSpeechSynthesizer sharedInstance] loadEnglishData:EnglishTextData speechData:EnglishSpeechData];
//    if(loadErr != nil)
//    {
//        // 处理出错状况
//    }
    
    // 获得合成器实例
    [[BDSSpeechSynthesizer sharedInstance] setSynthesizerDelegate:self];
    
    // 设置委托对象
    [[BDSSpeechSynthesizer sharedInstance] setSynthesizerDelegate:self];
    
    // 开始合成并播放
    NSError* speakError = nil;
    if([[BDSSpeechSynthesizer sharedInstance] speakSentence:@"您好" withError:&speakError] == -1){
        // 错误
        NSLog(@"错误: %ld, %@", (long)speakError.code, speakError.localizedDescription);
    }
    if([[BDSSpeechSynthesizer sharedInstance] speakSentence:@"今天天气真不错" withError:&speakError] == -1){
        // 错误
        NSLog(@"错误: %ld, %@", (long)speakError.code, speakError.localizedDescription);
    }
    if([[BDSSpeechSynthesizer sharedInstance] speakSentence:@"Today's weather is really good!" withError:&speakError] == -1){
        // 错误
        NSLog(@"错误: %ld, %@", (long)speakError.code, speakError.localizedDescription);
    }
    
    
}


- (void)synthesizerStartWorkingSentence:(NSInteger)SynthesizeSentence
{
    NSLog(@"Began synthesizing sentence %ld", (long)SynthesizeSentence);
}

- (void)synthesizerFinishWorkingSentence:(NSInteger)SynthesizeSentence
{
    NSLog(@"Finished synthesizing sentence %ld", (long)SynthesizeSentence);
}

- (void)synthesizerSpeechStartSentence:(NSInteger)SpeakSentence
{
    NSLog(@"Began playing sentence %ld", (long)SpeakSentence);
}

- (void)synthesizerSpeechEndSentence:(NSInteger)SpeakSentence
{
    NSLog(@"Finished playing sentence %ld", (long)SpeakSentence);
}

- (void)headViewCreat{
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, GFMainScreenWidth, 300 * widthScale)];
    
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bgImageView.userInteractionEnabled = YES;
    self.headImageView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.headImageView;
    self.tableView.showsVerticalScrollIndicator = NO;
}
- (void)loadData{
    //进行网络判断
    if (![ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning) {
        [GFProgressHUD showMessagewithoutView:@"无网络连接" afterDelay:2];
        return;
    }
    NSString *str = [NSString stringWithFormat:@"%@code=%@", caiPuList, self.codeStr];
   // NSLog(@"%@", str);
    [[AFNManagerRequest sharedUtil] requestGetAFURL:str parameters:nil succeed:^(id responseObject) {
       // NSLog(@"%@", responseObject);
        NSString *staut =[NSString stringWithFormat:@"%@", responseObject[@"res"]];
        if ([staut isEqualToString:@"2"]) {
            NSDictionary *data = responseObject[@"data"];
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data[@"img"]]]]];
                CIContext *context = [CIContext contextWithOptions:nil];
                CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
                CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
                [filter setValue:ciImage forKey:kCIInputImageKey];
                //设置模糊程度
                [filter setValue:@30.0f forKey: @"inputRadius"];
                CIImage *result = [filter valueForKey:kCIOutputImageKey];
                CGRect frame = [ciImage extent];
               // NSLog(@"%f,%f,%f,%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
                CGImageRef outImage = [context createCGImage: result fromRect:ciImage.extent];
                UIImage * blurImage = [UIImage imageWithCGImage:outImage];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.bgImageView.image = blurImage;
                    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data[@"img"] ]] placeholderImage:nil options:SDWebImageRefreshCached];
                    [self.animationView pause];
                    [self.animationView removeFromSuperview];
                });
                
                
               // NSLog(@"----------%@", data[@"healthStr"]);
                
                for (NSDictionary * dic in data[@"burden"]) {
                    BurdenModel *burden = [[BurdenModel alloc] init];
                    [burden setValuesForKeysWithDictionary:dic];
                    [self.burdenArray addObject:burden];
                }
                
                for (NSDictionary * dic in data[@"makes"]) {
                    MarkModel *mark = [[MarkModel alloc] init];
                    [mark setValuesForKeysWithDictionary:dic];
                    [self.makesArray addObject:mark];
                }
                
                [self.tableView reloadData];
               // NSLog(@"--------------------%@", self.makesArray);
            });
        }else{
            [GFProgressHUD showMessagewithoutView:@"数据请求失败,请再试" afterDelay:2];
            
        }
        
    } failure:^(NSError *errer) {
        [GFProgressHUD showMessagewithoutView:@"数据请求失败,请再试" afterDelay:2];
        
    }];
    
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section > 0 ) {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GFMainScreenWidth, 50 * widthScale)];
    headView.backgroundColor = [UIColor clearColor];
   UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 * widthScale, GFMainScreenWidth, 50 * widthScale)];
    titleLable.textColor = GFColor(145, 15, 6, 1);
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont systemFontOfSize:15 * widthScale];
    titleLable.numberOfLines = 1;
    titleLable.backgroundColor = [UIColor whiteColor];
    if (section == 1) {
      titleLable.text = @"配料";
    }else if ( section == 2){
    titleLable.text = @"做法";
    }
    [headView addSubview:titleLable];
    return headView;
    }else{
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GFMainScreenWidth, 0.1 * widthScale)];
        headView.backgroundColor = [UIColor clearColor];
        return headView;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section > 0 ) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GFMainScreenWidth, 20 * widthScale)];
        headView.backgroundColor = [UIColor clearColor];
       
        return headView;
    }else{
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GFMainScreenWidth, 0.1 * widthScale)];
        headView.backgroundColor = [UIColor clearColor];
        return headView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section > 0 ) {
        return 20 * widthScale;
    }else{
        return 0.1 * widthScale;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section > 0 ) {
        return 50 * widthScale;
    }else{
        return 0.1 * widthScale;
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.hatImage.image = [UIImage imageNamed:@"z_dish_detail_default_user_ico"];
        return cell;
        
    }
    if (indexPath.section == 1) {
        PeiLiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (cell == nil) {
            cell = [[PeiLiaoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
        }
       
            if (self.burdenArray.count > indexPath.row) {
                [cell configUI:self.burdenArray[indexPath.row]];
            }
     
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
        
    }
    if (indexPath.section == 2) {
        MarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
        if (cell == nil) {
            cell = [[MarkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier3];
        }
                  if (self.makesArray.count > indexPath.row) {
                [cell configUI:self.makesArray[indexPath.row]];
            }
       
       
        //NSLog(@"*****************************%ld", (long)indexPath.row);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;

        
    }
    return nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return self.burdenArray.count;
        
    }else if (section == 2){
        return self.makesArray.count;
    }
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 200 * widthScale;
    }else if (indexPath.section == 1){
        return 30 * widthScale;
    }else if (indexPath.section == 2){
        //取到对应行显示所用的model
            MarkModel *model = self.makesArray[indexPath.row];
            //通过每一行cell显示model的数据获取cell高度
            CGFloat cellHeight = [MarkTableViewCell getCellHeightWidthMangoModel:model];
            //获取cell高度后返回给tableView
            return cellHeight;
}
    return 0;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, GFMainScreenWidth, GFMainScreenHeight - 64) style:UITableViewStylePlain];
        self.tableView.separatorColor = [UIColor clearColor];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 200 * widthScale;
        
    }
    return _tableView;
}
- (NSMutableArray *)makesArray{
    if (_makesArray == nil) {
        self.makesArray = [NSMutableArray new];
    }
    return _makesArray;
}
- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        self.bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.bgImageView.userInteractionEnabled = YES;
        self.bgImageView.backgroundColor = [UIColor whiteColor];
    }
    return _bgImageView;
}
- (NSMutableArray *)burdenArray{
    if (_burdenArray == nil) {
        self.burdenArray = [NSMutableArray new];
    }
    return _burdenArray;
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
