//
//  AFNManagerRequest.h
//  GFNetwork
//
//  Created by ZZCN77 on 2017/4/12.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"  //AF 3.0 版本

#define BASE_URL @"http://xxx.xx.xx.174:80/AppFrameWork"

@interface AFNManagerRequest : NSObject
//请求网络的时候使用单利，以防止内存泄漏
/**
 *  类方法
 */
+ (AFNManagerRequest *)sharedUtil;


/**
 * AF数据请求
 */
//post
- (void)requestPostAFURL:(NSString *)URLString
         parameters:(id)parameters
            succeed:(void (^)(id responseObject))succeed
            failure:(void (^)(NSError *errer))failure;

//get
- (void)requestGetAFURL:(NSString *)URLString
         parameters:(id)parameters
            succeed:(void (^)(id responseObject))succeed
            failure:(void (^)(NSError *errer))failure;




/**
 * 上传多张图片
 */
- (void)requestAFURL:(NSString *)URLString
         parameters:(id)parameters
     imageDataArray:(NSArray *)imageDataArray
            succeed:(void (^)(id responseObject))succeed
            failure:(void (^)(NSError *errer))failure;

/**
 * 上传文件
 */
- (void)requestAFURL:(NSString *)URLString
         parameters:(id)parameters
           fileData:(NSData *)fileData
            succeed:(void (^)(id))succeed
            failure:(void (^)(NSError *))failure;
////下载文档
//+ (void)downLoadFileRequestAFURL:(NSString *)URLString fileData:(NSData *)fileData progress:(void (^)(NSProgress *downloadProgess))progress destination:(NSURL* (^)(NSURL *taretPath, NSURLResponse *response))destination completionHandler:(void (^)(NSURLResponse *resonse, NSURL *filePath, NSError * error))completionHandler;
//

//取消下载
- (void)cancleDownLoadFileWithServiceCreated:(NSURLSessionDownloadTask*)task fileName:(NSString *)fileName;// 正在下载中
- (NSString *)isDownLoadExecuting:(NSURLSessionDownloadTask*)task;

// 下载暂停
- (void)downLoadPause:(NSURLSessionDownloadTask*)task;

// 下载继续
- (void)downLoadResume:(NSURLSessionDownloadTask*)task;

























@end
