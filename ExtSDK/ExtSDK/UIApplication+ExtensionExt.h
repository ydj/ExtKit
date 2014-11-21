//  UIApplication+ExtensionExt.h
//
//  Copyright (c) 2014 YDJ ( https://github.com/ydj/ExtSDK )
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

/* @brief 主题更换通知 */
extern  NSString * const kTopicdidChangeNotification;
/* @brief 通知里面的对象key */
extern  NSString * const kCurrentTopicNotificationUserInfo;


@interface UIApplication (ExtensionExt)


/**
 *
 * @brief 是否打开崩溃记录，本地信息会写到本地的文件中,crashLogPath路径下
 *        默认是NO
 *
 */
@property (nonatomic,assign)BOOL isOpenCrashLog_Ext;

/**
 *
 * @brief 崩溃记录的路径，默认是在宏定义kCrashLogPath_Ext路径下
 *
 */
@property (nonatomic,copy)NSString * crashLogPath_Ext;

/**
 *	@brief	扩展图片/主题的名字,如果是默认主题就是返回@""
 */
@property (nonatomic,copy)NSString *topic_Ext;

/**
 *
 * @brief 隐藏键盘的按钮，使用方法
 *  [[UIApplication sharedApplication] setHiddenKeyBoardButton_Ext:NO];
 *  [[UIApplication sharedApplication] setHiddenKeyBoardButtonImage_Ext:[UIImage imageNamed:@"KeyboardIcon.png"]];
 *  [[UIApplication sharedApplication] setHiddenKeyBoardButtonImageHighlighted_Ext:[UIImage imageNamed:@"KeyboardIcon_h.png"]];
 *   [[UIApplication sharedApplication] setHiddenKeyBoardButtonoffset_Ext:CGPointMake(270, -40)];
 *
 */
@property (nonatomic,strong)UIImage * hiddenKeyBoardButtonImage_Ext;
@property (nonatomic,assign)CGPoint hiddenKeyBoardButtonoffset_Ext;
@property (nonatomic,strong)UIImage * hiddenKeyBoardButtonImageHighlighted_Ext;
/**
 * @brief 设置是否隐藏键盘上面的按钮，默认是隐藏
 *
 * @param _hidden YES 隐藏 ,NO 不隐藏 , 默认是隐藏
 *
 */
-(void)setHiddenKeyBoardButton_Ext:(BOOL)_hidden;

/**
 * @brief 返回是否隐藏了键盘上的按钮
 *
 * @param YES 已经隐藏, NO 没有隐藏
 *
 */
-(BOOL)HiddenKeyBoardButton_Ext;

/**
 * @brief 得到程序版本号,短字符版本1.1.1
 *
 * @return 版本字符串
 */
-(NSString *)getBundleShortVersionString_Ext;

/**
 * @brief 得到程序的build版本
 *
 * @return build版本字符串
 */
-(NSString *)getBundleVersion_Ext;

@end
