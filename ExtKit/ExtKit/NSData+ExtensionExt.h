//  NSData+ExtensionExt.h
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
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <Availability.h>
#import <zlib.h>


@interface NSData (ExtensionExt)


/**
 * @brief 数据进行MD5(32位)签名验证
 *
 * @return 签名后的数据
 */
-(NSData *)MD5D32HexDigest_Ext;

/**
 * @brief sha1签名验证
 *
 * @return 签名后的数据
 */
- (NSData *) SHA1Hash_Ext;

/**
 * @brief SHA224签名验证
 *
 * @return 签名后的数据
 */
- (NSData *) SHA224Hash_Ext;

/**
 * @brief SHA256签名验证
 *
 * @return 签名后的数据
 */
- (NSData *) SHA256Hash_Ext;

/**
 * @brief SHA384签名验证
 *
 * @return 签名后的数据
 */
- (NSData *) SHA384Hash_Ext;

/**
 * @brief SHA512签名验证
 *
 * @return 签名后的数据
 */
- (NSData *) SHA512Hash_Ext;

/**
 *	@brief	使用Key进行HMAC-SHA1加密
 *
 *	@param 	key 	密钥
 *
 *	@return	加密后数据
 */
- (NSData *)dataByUsingHMacSHA1WithKey_Ext:(NSData *)key;


/**
 * @brief 数据base64编码
 *
 * @return 编码后的数据
 */
-(NSData *)base64Encoded_Ext;

/**
 * @brief 数据base64解码
 *
 * @return 解码后的数据
 */
-(NSData *)base64Decoded_Ext;


/**
 * @brief 类方法，base64解码，从base64的字符串中得到data
 *
 * @param aString 经过base编码的字符串
 *
 * @param encode 字符串aString的编码格式
 *
 * @return 解码后的数据
 */
+ (NSData *)dataFromBase64String_Ext:(NSString *)aString encoding:(NSStringEncoding)encode;

/**
 * @brief 数据base64编码
 *
 * @param encoding 经过base64编码的后，返回字符串的格式编码(UTF-8,GB2313)
 *
 * @return 编码后的字符串
 */
- (NSString *)base64EncodedStringEncoding_Ext:(NSStringEncoding)encoding;

/**
 * @brief 数据base64解码
 *
 * @param encoding 经过base64解码的后，返回字符串的格式编码(UTF-8,GB2313)
 *
 * @return 解码后的字符串
 */
- (NSString *)base64DecodedStringEncoding_Ext:(NSStringEncoding)encoding;

/**
 * @brief 数据AES128位加密
 *
 * @param keyData 加密的key值数据(32位)可以进行md5
 *
 * @param iv_ 初始化向量值，可以为空
 *
 * @return 加密后的数据
 */
- (NSData *)dataUsingAES128EncryptWithkey_Ext:(NSData *)keyData withIV:(void *)iv_;

/**
 * @brief 数据AES128为解码
 *
 * @param keyData 解密的key值数据(32位) 可以进行md5
 *
 * @param iv_ 初始化向量值，可以为空
 *
 * @return 解密后的数据
 */
- (NSData *)dataUsingAES128DecryptWithkey_Ext:(NSData *)keyData withIV:(void *)iv_;


/**
 * @brief 数据AES256位加密
 *
 * @param keyData 加密的key值数据(64位) 
 *
 * @param iv_ 初始化向量值，可以为空
 *
 * @return 加密后的数据
 */
- (NSData *)dataUsingAES256EncryptWithkey_Ext:(NSData *)keyData withIV:(void *)iv_;

/**
 * @brief 数据AES256为解码
 *
 * @param keyData 解密的key值数据(64位) 
 *
 * @param iv_ 初始化向量值，可以为空
 *
 * @return 解密后的数据
 */
- (NSData *)dataUsingAES256DecryptWithkey_Ext:(NSData *)keyData withIV:(void *)iv_;


/**
 * @brief 数据进行3DES加密
 *
 * @param keyData 解密的key值,(40位),可以先进行SHA1Hash_Ext
 *
 * @param iv_ 初始化向量值，可以为空
 *
 * @return 加密后的数据
 */
- (NSData *)dataUsing3DESEncryptWithkey_Ext:(NSData *)keyData withIV:(void *)iv_;

/**
 * @brief 数据进行3DES解密
 *
 * @param keyData 解密的key值，(40位)可以先进行SHA1Hash_Ext
 *
 * @param iv_ 初始化向量值，可以为空
 *
 * @return 解密后的数据
 */
- (NSData *)dataUsing3DESDecryptWithkey_Ext:(NSData *)keyData withIV:(void *)iv_;

/**
 * @brief 数据进行DES加密
 *
 * @param keyData 界面的key值
 *
 * @param iv_ 初始化向量值，可以为空
 *
 * @return 加密后的数据
 */
- (NSData *)dataUsingDESEncryWithkey_Ext:(NSData *)keyData withIV:(void *)iv_;

/**
 * @brief 数据进行DES解密
 *
 * @param keyData 界面的key值
 *
 * @param iv_ 初始化向量值，可以为空
 *
 * @return 解密后的数据
 */
- (NSData *)dataUsingDESDencryWithkey_Ext:(NSData *)keyData withIV:(void *)iv_;

/**
 * @brief json数据解析成对象，
 *
 * @return 数组或者字典
 */
- (id)objectFromJSONData_Ext NS_AVAILABLE(10_7, 5_0);


/**
 *	加密解密方法
 *	@param edata     需要加密的数据
 *	@param kData     加密使用的key
 *	@param iv_byte   初始化向量
 *	@param operation 加密/解密
 *	@param algorithm 加解密的类型 AES、DES...
 *	@param keySize   加密类型对象的key大小，eg. kCCKeySizeDES/kCCKeySizeAES128...
 *	@param options   加密的模块类型 PKCS7/ECB
 *	@return  加解密后的数据
 */
-(NSData *)cipherData_Ext:(NSData *)edata withkey:(NSData *)kData withIV:(void *)iv_byte  Operation:(CCOperation)operation Algorithm:(CCAlgorithm)algorithm keySize:(uint8_t)keySize options:(CCOptions)options;


/**
 *	gzip压缩
 *	@return 压缩后的数据
 */
- (NSData *)gzipData_Ext;

/**
 *	gzip解压缩
 *	@return 解压后的数据
 */
- (NSData *)ungzipData_Ext;

@end
