//
//  Header.h
//  CaiPu
//
//  Created by ZZCN77 on 2017/6/12.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#ifndef Header_h
#define Header_h
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]/// rgb颜色转换（16进制->10进制）

#define GFColor(r, g, b, c) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0  blue:(b) / 255.0  alpha:c]
#define K9TextColor [UIColor colorWithRed:(153) / 255.0 green:(153) / 255.0  blue:(153) / 255.0  alpha:1.0]
#define K6TextColor [UIColor colorWithRed:(102) / 255.0 green:(102) / 255.0  blue:(102) / 255.0  alpha:1.0]
#define K3TextColor [UIColor colorWithRed:(51) / 255.0 green:(51) / 255.0  blue:(51) / 255.0  alpha:1.0]
#define KfColor [UIColor colorWithRed:(251) / 255.0 green:(251) / 255.0  blue:(251) / 255.0  alpha:1.0]
/******* 屏幕尺寸 *******/
#define GFMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define GFMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define GFMainScreenBounds [UIScreen mainScreen].bounds

#define widthScale GFMainScreenWidth / 375.0
#define heightScale GFMainScreenHeight / 667.0

/******* 屏幕尺寸 *******/


//中餐列表
#define zhongcaiList @"http://api.xiangha.com/category/home/getClassData?"

//川菜
#define caiList @"http://api.xiangha.com/category/so/getSoCaipu/?"

//菜谱
#define caiPuList @"http://api.xiangha.com/category/caipu/getDishInfo/?"













#endif /* Header_h */
/******* 日志打印替换 *******/
#ifdef DEBUG
// Debug
#define NSLog(FORMAT, ...) fprintf(stderr, "%s [%d lines] %s\n", __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
// Release
#define NSLog(FORMAT, ...) nil
#endif
/******* 日志打印替换 *******/
