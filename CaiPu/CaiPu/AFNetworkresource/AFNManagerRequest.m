//
//  AFNManagerRequest.m
//  GFNetwork
//
//  Created by ZZCN77 on 2017/4/12.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import "AFNManagerRequest.h"

@implementation AFNManagerRequest
/**
 *  类方法
 */
+ (AFNManagerRequest *)sharedUtil {
    
    static dispatch_once_t  onceToken;
    static AFNManagerRequest * setSharedInstance;
    
    dispatch_once(&onceToken, ^{
        setSharedInstance = [[AFNManagerRequest alloc] init];
        
    });
    return setSharedInstance;
}



/**
 * AF网络请求
 */
- (void)requestGetAFURL:(NSString *)URLString parameters:(id)parameters succeed:(void (^)(id))succeed failure:(void (^)(NSError *))failure{
    // 1.创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];

    // 2.申明返回的结果是二进制类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 3.如果报接受类型不一致请替换一致text/html  或者 text/plain
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", @"application/javascript",@"application/json; charset=utf-8",nil];
    
    // 4.请求超时，时间设置
    manager.requestSerializer.timeoutInterval = 30;
    
    
    NSDictionary *headerFieldValueDictionary = @{@"Host":@"api.xiangha.com", @"Charset":@"UTF-8", @"Connection":@"keep-alive", @"Cookie" : @"device=and#vivo Y18L#4.4.2#1.9.0#720#1280#xiangha_app_com.xiangha.caipudaquan#wifi#1016#com.xiangha.caipudaquan#10#;xhCode=12F209A55B8A910D62BD4E8A822DA0F6;"};
    if (headerFieldValueDictionary != nil) {
        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
            NSString *value = headerFieldValueDictionary[httpHeaderField];
            [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    manager.requestSerializer = requestSerializer;
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if(succeed){
            succeed(dict);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        NSLog(@"\n 请求失败:%@\n\n",error);
        
    }];

}
- (void)requestPostAFURL:(NSString *)URLString parameters:(id)parameters succeed:(void (^)(id))succeed failure:(void (^)(NSError *))failure{
    // 1.创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2.申明返回的结果是二进制类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 3.如果报接受类型不一致请替换一致text/html  或者 text/plain
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"text/html; charset=UTF-8",  nil];
    
    // 4.请求超时，时间设置
    manager.requestSerializer.timeoutInterval = 30;
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if(succeed){
            succeed(dict);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        
        NSLog(@"\n 请求失败:%@\n\n",error);
        
        
    }];

}





/**
 * 上传多张图片
 */
- (void)requestAFURL:(NSString *)URLString parameters:(id)parameters imageDataArray:(NSArray *)imageDataArray succeed:(void (^)(id))succeed failure:(void (^)(NSError *))failure
{


    
    // 1.创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2.申明返回的结果是二进制类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 3.如果报接受类型不一致请替换一致text/html  或者 text/plain
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",  nil];
    
    // 4.请求超时，时间设置
    manager.requestSerializer.timeoutInterval = 30;
    
    // 5. POST数据
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i<imageDataArray.count; i++){
            
            
            NSData * imageData = [imageDataArray objectAtIndex: i];
            // 上传的参数名
            NSString * Name = [NSString stringWithFormat:@"file%d",i+1];
            // 上传filename
            NSString * fileName = [NSString stringWithFormat:@"%@.jpg", Name];
            
            [formData appendPartWithFileData:imageData name:Name fileName:fileName mimeType:@"image/jpg"];

        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        succeed(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       failure(error);
    }];
    
    
    
    
}


/**
 * 上传文件
 */
- (void)requestAFURL:(NSString *)URLString
         parameters:(id)parameters
           fileData:(NSData *)fileData
            succeed:(void (^)(id))succeed
            failure:(void (^)(NSError *))failure
{
    // 0.设置API地址
    URLString = [NSString stringWithFormat:@"%@%@",BASE_URL,[URLString stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
    
//    DNSLog(@"\n POST上传文件参数列表:%@\n\n%@\n",parameters,[Utilit URLEncryOrDecryString:parameters IsHead:false]);
    
    // 1.创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2.申明返回的结果是二进制类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 3.如果报接受类型不一致请替换一致text/html  或者 text/plain
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",  nil];
    
    // 4.请求超时，时间设置
    manager.requestSerializer.timeoutInterval = 30;
    
    // 5. POST数据
    [manager POST:URLString  parameters:parameters  constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //将得到的二进制数据拼接到表单中 /** data,指定上传的二进制流;name,服务器端所需参数名*/
        [formData appendPartWithFileData :fileData name:@"file" fileName:@"audio.MP3" mimeType:@"audio/MP3"];
        
    }progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *responseStr =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        succeed(responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
    
}


//+ (void)downLoadFileRequestAFURL:(NSString *)URLString fileData:(NSData *)fileData progress:(void (^)(id))progress succeed:(void (^)(id))succeed failure:(void (^)(NSError *))failure{
//    
//    NSString *fileName = [URLString lastPathComponent];
//    //判断用户是否已经下载文件
//    // 判断是否已经离线下载了
//    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
//    
//    NSFileManager *filemanager = [NSFileManager defaultManager];
//    
//    if ([filemanager fileExistsAtPath:path] == YES) {
//        NSLog(@"本地存在");
//        return;
//    }
//
////    //下载
////    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
////    AFHTTPSessionManager *sessionManger = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
////    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
////    NSURLSessionDownloadTask *task = [sessionManger downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
////        progress(downloadProgress);
////    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
////
////    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
////        failure(filePath);
////    }];
////    [task resume];
//}


/**
 *  取消下载，并删除本地已经下载了的部分
 *
 *  @param fileName 文件的名字
 */
- (void)cancleDownLoadFileWithServiceCreated:(NSURLSessionDownloadTask*)task fileName:(NSString *)fileName
{
    [task cancel];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];

    // 删除本地文件
    NSString *localSavePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
    
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:localSavePath]) {
        [filemanager removeItemAtPath:localSavePath error:nil];
    }
    
}

// 正在下载中
- (NSString *)isDownLoadExecuting:(NSURLSessionDownloadTask*)task
{
    switch (task.state) {
        case NSURLSessionTaskStateRunning:
            return @"正在下载";
            break;
        case NSURLSessionTaskStateSuspended:
            return @"停止下载";
            break;
        case NSURLSessionTaskStateCanceling:
            return @"取消下载";
            break;
        case NSURLSessionTaskStateCompleted:
            return @"下载完成";
            break;
            

        default:
            break;
    }
    
    
    return  nil;
}
// 下载暂停
- (void)downLoadPause:(NSURLSessionDownloadTask *)task
{
    [task suspend];
}
// 下载继续
- (void)downLoadResume:(NSURLSessionDownloadTask *)task
{
    [task resume];
}







@end
