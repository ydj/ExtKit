//  UIDevice+ExtensionExt.h
//
//  Copyright (c) 2014 YDJ ( https://github.com/ydj/ExtKit )
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.



#import <UIKit/UIKit.h>
#import <Security/Security.h>



@interface UIDevice (ExtensionExt)


/**
 * @brief 判断是否是3.5寸屏幕的设备
 *
 * @return YES 是，NO 不是
 */
- (BOOL)is3_5Inch_Ext;

/**
 * @brief 判断是否是4寸屏幕的设备
 *
 * @return YES 是，NO 不是
 */
- (BOOL)is4Inch_Ext;

/**
 * @brief 判断是否是4.7寸屏幕的设备
 *
 * @return YES 是，NO 不是
 */
- (BOOL)is4_7Inch_Ext;

/**
 * @brief 判断是否是5.5寸屏幕的设备
 *
 * @return YES 是，NO 不是
 */
- (BOOL)is5_5Inch_Ext;

/**
 * @brief 判断设备是否retain屏幕
 *
 * @return YES 是，NO 不是
 */
- (BOOL)isRetain_Ext;

/**
 * @brief 判断设备是否越狱
 *
 * @return YES 越狱，NO 未越狱
 */
- (BOOL)isJailbroken_Ext;


/**
 * @brief 获得设备的唯一标示
 *
 * @return 返回设备的唯一标示
 */
- (NSString *)udidString_Ext;

/**
 * @brief 获得系统的进程
 *
 * @return 返回数组，数组中是字典，包括进程的id和名称
 */
- (NSArray *)runningProcesses_Ext;

/**
 * @brief 获得系统的名称，ios
 *
 * @return 返回名称字符串
 */
- (NSString *)systemNameString_Ext;

/**
 * @brief 获得系统的版本号，6.1.3
 *
 * @return 版本号字符串
 */
- (NSString *)systemVersionString_Ext;

/**
 * @brief 获取设备的名字,xx的iPhone
 *
 * @return 设备名字
 */
- (NSString *)deviceNameString_Ext;

/**
 * @brief model的名字
 *
 * @return model字符串
 */
- (NSString *)localizedModelString_Ext;

/**
 * @brief 平台的信息
 *
 * @return 信息字符串
 */
- (NSString *) platform_Ext;



@end
