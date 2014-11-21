//  CommonExt.h
//
//  Copyright (c) 2014 NextDj (https://github.com/ydj/ExtSDK)
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



#import <Foundation/Foundation.h>

/**
 *	常用的辅助方法
 */
@interface HelperExt : NSObject

/**
 *	随机生成UUID
 *	@return 生成的uuid字符串
 */
+(NSString*)getUUID_Ext;

/**
 *	生成随机数
 *	@param length 随机数的位数
 *	@return 随机数的字符串
 */
+(NSString *)getRandomNumberwithLength_Ext:(int)length;

 /**
 *	生成随机字符串，区分大小写
 *	@param  字符长度
 *	@return 字符串
 */
+(NSString *)getRandomStringwithLength_Ext:(int)length;

/**
 *	生成随机字符和数字字符串
 *	@param length 字符串的长度
 *	@return 字符串
 */
+(NSString *)getRandomNumberAndStringWithLength_Ext:(int)length;


@end
