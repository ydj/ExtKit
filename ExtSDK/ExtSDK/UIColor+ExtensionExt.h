//  UIColor+ExtensionExt.h
//
//  Copyright (c) 2014 YDJ (ExtSDK) (https://github.com/ydj/ExtSDK)
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

@interface UIColor (ExtensionExt)

/**
 * @brief 字符串中得到颜色值
 *
 * @param stringToConvert 字符串的值 e.g:@"#FF4500"
 *
 * @return 返回颜色对象
 */
+ (UIColor *)colorFromString_Ext:(NSString *)stringToConvert;


/**
 * @brief RGBA风格获取颜色，
 * UIColor *solidColor = [UIColor colorWithRGBA_Ext:0xFF0000FF];
 *
 * @param hex 是16进止rgba值
 *
 * @return 颜色对象
 */
+ (UIColor *) colorWithRGBA_Ext:(uint) hex;


/**
 * @brief ARGB风格获取颜色
 * UIColor *alphaColor = [UIColor colorWithHex:0x99FF0000];
 *
 * @param hex argb的值
 *
 * @return 颜色对象
 */
+ (UIColor *) colorWithARGB_Ext:(uint) hex;


/**
 * @brief RGB风格获取颜色值
 *UIColor *solidColor = [UIColor colorWithHex:0xFF0000];
 *
 * @param hex rgb的值
 *
 * @return 颜色对象
 */
+ (UIColor *) colorWithRGB_Ext:(uint) hex;

/*usage
 safe to omit # sign as well
 UIColor *solidColor = [UIColor colorWithWeb:@"FF0000"];
 */

/**
 * @brief 根据字符串返回颜色值
 * UIColor *solidColor = [UIColor colorWithWeb:@"#FF0000"];
 * UIColor *solidColor = [UIColor colorWithWeb:@"FF0000"];
 *
 * @param hexString 字符串的值，e.g:@"#FF0000" @"FF0000"
 *
 * @return 颜色对象
 */
+ (UIColor *)colorWithHexString_Ext:(NSString *)hexString;

/**
 * @brief 颜色对象返回字符串
 *
 * @return 颜色字符串
 */
- (NSString *) hexString_Ext;

/**
 * @brief 得到颜色R值
 *
 * @return 返回R值
 */
- (CGFloat)r_Ext;

/**
 * @brief 得到颜色的G值
 *
 * @return 返回颜色的G值
 */
- (CGFloat)g_Ext;

/**
 * @brief 得到颜色的B值
 *
 * @return 返回颜色的B值
 */
- (CGFloat)b_Ext;

/**
 * @brief 得到颜色的A值
 *
 * @return 返回颜色的A值
 */
- (CGFloat)a_Ext;


@end
