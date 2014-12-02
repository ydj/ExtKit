//  NSString+ExtensionExt.h
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


@interface NSString (ExtensionExt)

/**
 * @brief 使用MD5算法进行签名（16位）
 *
 * @return 签名后字符串
 */
- (NSString *)md5HexDigestString_Ext;

/**
 * @brief 使用MD5算法进行签名（32位）
 *
 * @return 签名后字符串
 */
- (NSString *)md5DHexDigestString_Ext;

/**
 * @brief 使用SHA1算法进行签名
 *
 * @return 签名后字符串
 */
- (NSString *)sha1String_Ext;

/**
 *	@brief	使用HMac-SHA1进行签名
 *
 *	@param 	key 	密钥
 *
 *	@return	签名后字符串
 */
- (NSString *)hmacsha1StringWithKey_Ext:(NSString *)key;

/**
 *	@brief	使用HMac-SHA1进行签名
 *
 *	@param 	key 	密钥
 *
 *	@return	签名后的数据
 */
- (NSData *)dataUsinghmacsha1StringWithKey_Ext:(NSString *)key;


/**
 *	全部进行url编码 !*'();:@&=+$,%#[]
 *	@param encodeing 编码格式 kCFStringEncodingUTF8
 *	@return 编码后的字符串
 */
- (NSString *)urlEncodeAllRecode:(CFStringEncoding)encodeing;

/**
 * @brief url编码,使用utf8编码
 *
 * @return 编码后的字符串
 */
- (NSString *)urlEncodeUTF8_Ext;
/**
 * @brief url解码,使用utf8解码
 *
 * @return 解码后的字符串
 */
- (NSString *)urlDecodeUTF8_Ext;

/**
 * @brief  URL字符串编码
 *
 * @param encodeing 编码格式
 *
 * @return 编码后的字符串
 */
- (NSString *)urlEncode_Ext:(CFStringEncoding)encodeing;

/**
 * @brief URL字符串解码
 *
 * @param decodeing 编码格式
 *
 * @return 解码后的字符串
 */
- (NSString *)urlDecode_Ext:(NSStringEncoding)decodeing;

/**
 * @brief 字符串base64编码
 *
 * @param encoding 需要编码的字符串格式以及返回字符串的格式(UTF-8,GB2313...)
 *
 * @return 编码后的字符串
 */
- (NSString *)base64EncodedStringEncoding_Ext:(NSStringEncoding)encoding;

/**
 * @brief 字符串base64解码
 *
 * @param encoding 解码的字符串格式以及返回字符串的格式(UTF-8.GB2313...)
 *
 * @return 解码后的字符串
 */
- (NSString *)base64DecodedStringEncoding_Ext:(NSStringEncoding)encoding;

/**
 * @brief 字符串base64编码，默认编码格式时候UTF8
 *
 * @return 编码后的字符串
 */
- (NSString *)base64Encoded_Ext;

/**
 * @brief 字符串base64解码，默认编码格式时候UTF8
 *
 * @return 解码后的字符串
 */
- (NSString *)base64Decoded_Ext;

/**
 * @brief 字符串base64编码,utf8
 *
 * @return 编码后的数据data
 */
- (NSData *)base64DataFromString_Ext;

/**
 * @brief 字符串base64解码，使用UTF8
 *
 * @return 返回解码后的数据data
 */
- (NSData *)dataFromBase64String_Ext;

/**
 *	@brief	取得汉字的拼音首字母
 *
 *	@return	拼音首字母字符串(大写)
 */
- (NSString *)pinyinFirstLetter_Ext;

/**
 *	@brief	汉字转拼音字符串,带声调
 *
 *	@return	拼音字符串(小写)
 */
- (NSString *)pinyinString_Ext;

/**
 * @brief	汉字转拼音字符串没有声调
 *
 * @return 拼音字符串
 */
- (NSString *)pinyinNoTone_Ext;

/**
 * @brief	汉字转拼音字符串没有声调和空格
 *
 * @return 拼音字符串
 */
- (NSString *)pinyinNoToneAndSpace_Ext;

/**
 * @brief 字符串AES128位加密
 *
 * @param key 加密需要的key值,长度最少是16bit，可以进行md5、hash之后当key值
 *
 * @param encoding 加密需要转换的编码格式
 *
 * @return 加密后base64编码之后的字符串
 */
- (NSString *)stringUsingAES128EncryptWithkey_Ext:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_;

/**
 * @brief 字符串AES128位解密
 *
 * @param key 加密需要的key值,长度最少是16bit，可以进行md5、hash之后当key值
 *
 * @param encoding 解密需要转换的编码格式
 *
 * @return 解密后base64解码之后的字符串
 */
- (NSString *)stringUsingAES128DencryptWithkey_Ext:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_;


/**
 * @brief 字符串DES加密
 *
 * @param key 加密时需要的key值...
 *
 * @return 加密后的字符串
 */
- (NSString *)stringUsingDESEncryWithkey_Ext:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_;

/**
 * @brief 字符串DES解密
 *
 * @param key 解密时需要的key值...
 *
 * @return 解密后的字符串
 */
- (NSString *)stringUsingDESDencryWithkey_Ext:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_;


/**
 * @brief json字符串转换成字符串,使用UTF8编码
 *
 * @return 数组或者字典对象
 */
- (id)objectFromJSONString_Ext NS_AVAILABLE(10_7, 5_0);

@end
