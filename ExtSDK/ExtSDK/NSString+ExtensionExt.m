//  NSString+ExtensionExt.m
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



#import "NSString+ExtensionExt.h"
#import "NSData+ExtensionExt.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (ExtensionExt)

/**
 * @brief 使用MD5算法进行签名（16位）
 *
 * @return 签名后字符串
 */
- (NSString *)md5HexDigestString_Ext
{
    if (self==nil) {
        return nil;
    }
    return [[self md5DHexDigestString_Ext] substringWithRange:NSMakeRange(8, 16)];
}

/**
 * @brief 使用MD5算法进行签名（32位）
 *
 * @return 签名后字符串
 */
- (NSString *)md5DHexDigestString_Ext
{
    if (self==nil) {
        return nil;
    }
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result ); // This is the md5 call
        
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}


/**
 * @brief 使用SHA1算法进行签名
 *
 * @return 签名后字符串
 */
- (NSString *)sha1String_Ext
{
    if (self==nil) {
        return self;
    }
    const char *cStr = [self UTF8String];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}

/**
 *	@brief	使用HMac-SHA1进行签名
 *
 *	@param 	key 	密钥
 *
 *	@return	签名后字符串
 */
- (NSString *)hmacsha1StringWithKey_Ext:(NSString *)key
{
    if (self==nil) {
        return nil;
    }
    const char * ckey=[key UTF8String];
    const char * cdata=[self UTF8String];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
	CCHmac(kCCHmacAlgSHA1, ckey, strlen(ckey), cdata, strlen(cdata), cHMAC);

   __autoreleasing NSString * string=[[NSString alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH encoding:NSUTF8StringEncoding];
    return string;
}


/**
 *	@brief	使用HMac-SHA1进行签名
 *
 *	@param 	key 	密钥
 *
 *	@return	签名后的数据
 */
- (NSData *)dataUsinghmacsha1StringWithKey_Ext:(NSString *)key
{
    if (self==nil) {
        return nil;
    }
    const char * ckey=[key UTF8String];
    const char * cdata=[self UTF8String];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
	CCHmac(kCCHmacAlgSHA1, ckey, strlen(ckey), cdata, strlen(cdata), cHMAC);
    NSData * data=[NSData dataWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    return data;
}

/**
 * @brief  URL字符串编码
 *
 * @param encodeing 编码格式
 *
 * @return 编码后的字符串
 */
- (NSString *)urlEncode_Ext:(CFStringEncoding)encodeing
{
    return [self stringByAddingPercentEscapesUsingEncoding:encodeing];
    /*
    //kCFStringEncodingUTF8
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    NSString *outputStr = (NSString *)
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            NULL,
                                            (CFStringRef)@"!*'();:@&=+$,%#[]",
                                            encodeing);
    return [outputStr autorelease];
     */
}

- (NSString *)urlEncodeUTF8_Ext
{
    return [self urlEncode_Ext:NSUTF8StringEncoding];
}

- (NSString *)urlDecodeUTF8_Ext
{
    return [self urlDecode_Ext:NSUTF8StringEncoding];
}
/**
 * @brief URL字符串解码
 *
 * @param decodeing 编码格式
 *
 * @return 解码后的字符串
 */
- (NSString *)urlDecode_Ext:(NSStringEncoding)decodeing
{
    if (self==nil) {
        return nil;
    }
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:decodeing];
}

/**
 * @brief 字符串base64编码
 *
 * @param encoding 需要编码的字符串格式以及返回字符串的格式(UTF-8,GB2313...)
 *
 * @return 编码后的字符串
 */
- (NSString *)base64EncodedStringEncoding_Ext:(NSStringEncoding)encoding
{
    if (self==nil ) {
        return nil;
    }
    NSData * data=[self dataUsingEncoding:encoding];
    return [data base64EncodedStringEncoding_Ext:encoding];
}

/**
 * @brief 字符串base64解码
 *
 * @param encoding 解码的字符串格式以及返回字符串的格式(UTF-8.GB2313...)
 *
 * @return 解码后的字符串
 */
- (NSString *)base64DecodedStringEncoding_Ext:(NSStringEncoding)encoding
{
    if (self==nil) {
        return nil;
    }
    NSData * data=[NSData dataFromBase64String_Ext:self encoding:encoding];
    __autoreleasing NSString * result=[[NSString alloc] initWithData:data encoding:encoding];
    return result;
}

/**
 * @brief 字符串base64编码，默认编码格式时候UTF8
 *
 * @return 编码后的字符串
 */
- (NSString *)base64Encoded_Ext
{
   return [self base64EncodedStringEncoding_Ext:NSUTF8StringEncoding];
}

/**
 * @brief 字符串base64解码，默认编码格式时候UTF8
 *
 * @return 解码后的字符串
 */
- (NSString *)base64Decoded_Ext
{
    return [self base64DecodedStringEncoding_Ext:NSUTF8StringEncoding];
}

/**
 * @brief 字符串base64编码,utf8
 *
 * @return 编码后的数据data
 */
- (NSData *)base64DataFromString_Ext
{
    NSData * data=[self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64Encoded_Ext];
}

/**
 * @brief 字符串解码，使用UTF8
 *
 * @return 返回解码后的数据data
 */
- (NSData *)dataFromBase64String_Ext
{
    if (self==nil) {
        return nil;
    }
    return [NSData dataFromBase64String_Ext:self encoding:NSUTF8StringEncoding];
}

/**
 *	@brief	汉字转拼音字符串
 *
 *	@return	拼音字符串(小写)
 */
- (NSString *)pinyinString_Ext
{
    if (self==nil) {
        return nil;
    }
    
    CFMutableStringRef string =CFStringCreateMutableCopy(NULL, 0, (CFStringRef)self);
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
   // CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    
    CFAutorelease(string);
    
    return (__bridge NSString *)string;
}


- (NSString *)pinyinNoTone_Ext
{
    if (self==nil) {
        return nil;
    }
    
    CFMutableStringRef string =CFStringCreateMutableCopy(NULL, 0, (CFStringRef)self);
    ///转换成拼音
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    ///去掉声调
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    CFAutorelease(string);    //
    
    return (__bridge NSString *)string;
}

- (NSString *)pinyinNoToneAndSpace_Ext
{
    if (self==nil) {
        return nil;
    }
    NSString * string=[self pinyinNoTone_Ext];
    string=[string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string;
}


/**
 *	@brief	取得汉字的拼音首字母
 *
 *	@return	拼音首字母字符串(大写)
 */
- (NSString *)pinyinFirstLetter_Ext
{
    if (self==nil) {
        return nil;
    }
    NSMutableString * string=[NSMutableString string];
    
    @try {
        NSString *noToneString=[self pinyinNoTone_Ext];
        NSArray *spaceList=[noToneString componentsSeparatedByString:@" "];
        for (int i=0; i<[spaceList count]; i++) {
            [string appendFormat:@"%c",[spaceList[i] UTF8String][0]];
        }
        
        /*
        for (int i=0; i<[self length]; i++) {
            [string appendFormat:@"%c",ESPinyinFirstLetter_Ext([string characterAtIndex:i])];
        }*/
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
   
    
    return [string uppercaseString];
}


- (NSString *)stringUsingAES128EncryptWithkey_Ext:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_
{

    NSData * data=[self dataUsingEncoding:encoding];
    
    NSData * enData=[data dataUsingAES128EncryptWithkey_Ext:[key dataUsingEncoding:encoding] withIV:iv_];

    return [enData base64EncodedStringEncoding_Ext:encoding];
    
}
- (NSString *)stringUsingAES128DencryptWithkey_Ext:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_
{
   
    NSData * data=[NSData dataFromBase64String_Ext:self encoding:encoding];
    
    NSData * deData=[data dataUsingAES128DecryptWithkey_Ext:[key dataUsingEncoding:encoding] withIV:iv_];
    __autoreleasing NSString * result=[[NSString alloc] initWithData:deData encoding:encoding];
   return  result;
}


- (NSString *)stringUsingDESEncryWithkey_Ext:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_
{

    NSData * data=[self dataUsingEncoding:encoding];
    
    NSData * enData=[data dataUsingDESEncryWithkey_Ext:[key dataUsingEncoding:encoding] withIV:iv_];
    
    return [enData base64EncodedStringEncoding_Ext:encoding];
}

- (NSString *)stringUsingDESDencryWithkey_Ext:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_
{
    NSData * data=[NSData dataFromBase64String_Ext:self encoding:encoding];
    NSData * deData=[data dataUsingDESDencryWithkey_Ext:[key dataUsingEncoding:encoding] withIV:iv_];
    __autoreleasing NSString * result=[[NSString alloc] initWithData:deData encoding:NSUTF8StringEncoding];
    return result;
}


/**
 * @brief json字符串转换成字符串,使用UTF8编码
 *
 * @return 数组或者字典对象
 */
- (id)objectFromJSONString_Ext
{
    NSData * data=[self dataUsingEncoding:NSUTF8StringEncoding];
    return [data objectFromJSONData_Ext];
}



@end
