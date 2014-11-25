//  NSObject+ExtensionExt.h
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



#import <Foundation/Foundation.h>

@interface NSObject (ExtensionExt)

@property (nonatomic,strong)NSDictionary * userInfo_Ext;

/**
 * @brief 进行encoder操作的方法
 *
 * @param obj 要进行coder的对象，该对象应接受NSCoding协议，实现协议的方法
 *
 * @param path_ 存放的路径名称，e.g:/users/test/data
 *
 * @return 操作是否成功,YES 成功，NO 失败
 */
- (BOOL)encoderObject_Ext:(id)obj withPath:(NSString *)path_;

/**
 * @brief 解析解码Decoder操作
 *
 * @param path_ 文件的路径，e.g:/users/test/data
 *
 * @return 返回解码后的对象
 */
- (id)decoderObjectPath_Ext:(NSString *)path_;

/**
 * @brief data写入本地
 *
 * @param path 存放的路径名称，e.g:/users/test/data
 * @param data 要存放的数据
 *
 */
-(void)writeToFile_Ext:(NSString *)path data:(NSData *)data;


/**
 * 对象序列成字典
 *
 * @param obj 需要序列化的对象
 *
 * @return 字典
 */
- (NSDictionary*)getDictionaryFromObject_Ext:(id)obj;

/**
 * 将对象序列换成JSON字符串
 *
 * @param obj 需要序列换的参数
 * @param error 失败时，失败信息
 *
 * @return 修改的json的数据data
 */
- (NSData*)getJSON_Ext:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error;

@end
