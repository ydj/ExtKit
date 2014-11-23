//  UIView+ExtensionExt.h
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

@interface UIView (ExtensionExt)

/**
 * @brief 获得视图的x值
 *
 * @return x值
 */
- (CGFloat)frameX_Ext;

/**
 * @brief 获得视图的y值
 *
 * @return y值
 */
- (CGFloat)frameY_Ext;

/**
 *	@brief	获取视图宽度
 *
 *	@return	宽度值（像素）
 */
- (CGFloat)frameWidth_Ext;


/**
 *	@brief	获取视图高度
 *
 *	@return	高度值（像素）
 */
- (CGFloat)frameHeight_Ext;


/**
 *	@brief	获取view的截图
 *
 *	@return	图片
 */
- (UIImage *)screenshot_Ext;


/**
 *	@brief	得到当前的第一响应者
 *
 *	@return	返回第一响应者，没有返回nil
 */
- (UIView *)currentFirstResponderView_Ext;


@end



