//  NSData+ExtensionExt.m
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



#import "NSData+ExtensionExt.h"
#import "ExtMacros.h"

@implementation NSData (ExtensionExt)


-(NSData *)MD5D32HexDigest_Ext
{
    if (self==nil) {
        return nil;
    }
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

- (NSData *) SHA1Hash_Ext
{
	unsigned char hash[CC_SHA1_DIGEST_LENGTH];
	(void) CC_SHA1( [self bytes], (CC_LONG)[self length], hash );
	return ( [NSData dataWithBytes: hash length: CC_SHA1_DIGEST_LENGTH] );
}


- (NSData *) SHA224Hash_Ext
{
	unsigned char hash[CC_SHA224_DIGEST_LENGTH];
	(void) CC_SHA224( [self bytes], (CC_LONG)[self length], hash );
	return ( [NSData dataWithBytes: hash length: CC_SHA224_DIGEST_LENGTH] );
}

- (NSData *) SHA256Hash_Ext
{
	unsigned char hash[CC_SHA256_DIGEST_LENGTH];
	(void) CC_SHA256( [self bytes], (CC_LONG)[self length], hash );
	return ( [NSData dataWithBytes: hash length: CC_SHA256_DIGEST_LENGTH] );
}

- (NSData *) SHA384Hash_Ext
{
	unsigned char hash[CC_SHA384_DIGEST_LENGTH];
	(void) CC_SHA384( [self bytes], (CC_LONG)[self length], hash );
	return ( [NSData dataWithBytes: hash length: CC_SHA384_DIGEST_LENGTH] );
}

- (NSData *) SHA512Hash_Ext
{
	unsigned char hash[CC_SHA512_DIGEST_LENGTH];
	(void) CC_SHA512( [self bytes], (CC_LONG)[self length], hash );
	return ( [NSData dataWithBytes: hash length: CC_SHA512_DIGEST_LENGTH] );
}

/**
 *	@brief	使用Key进行HMAC-SHA1加密
 *
 *	@param 	key 	密钥
 *
 *	@return	加密后数据
 */
- (NSData *)dataByUsingHMacSHA1WithKey_Ext:(NSData *)key
{
    if (self==nil) {
        return nil;
    }
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
	CCHmac(kCCHmacAlgSHA1, key.bytes, strlen(key.bytes), self.bytes, strlen(self.bytes), cHMAC);
    
    NSData * data=[NSData dataWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    return data;
}


- (NSData *)base64Encoded_Ext
{
    NSInteger wrapWidth = 0;
    wrapWidth=(wrapWidth / 4) * 4;
    
    const char lookup[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    long long inputLength = [self length];
    const unsigned char *inputBytes = [self bytes];
    
    long  long maxOutputLength = (inputLength / 3 + 1) * 4;
    maxOutputLength += wrapWidth? (maxOutputLength / wrapWidth) * 2: 0;
    unsigned char *outputBytes = (unsigned char *)malloc((unsigned long)maxOutputLength);
    
    long long i;
    long long outputLength = 0;
    for (i = 0; i < inputLength - 2; i += 3)
    {
        outputBytes[outputLength++] = lookup[(inputBytes[i] & 0xFC) >> 2];
        outputBytes[outputLength++] = lookup[((inputBytes[i] & 0x03) << 4) | ((inputBytes[i + 1] & 0xF0) >> 4)];
        outputBytes[outputLength++] = lookup[((inputBytes[i + 1] & 0x0F) << 2) | ((inputBytes[i + 2] & 0xC0) >> 6)];
        outputBytes[outputLength++] = lookup[inputBytes[i + 2] & 0x3F];
        
        //add line break
        if (wrapWidth && (outputLength + 2) % (wrapWidth + 2) == 0)
        {
            outputBytes[outputLength++] = '\r';
            outputBytes[outputLength++] = '\n';
        }
    }
    
    //handle left-over data
    if (i == inputLength - 2)
    {
        // = terminator
        outputBytes[outputLength++] = lookup[(inputBytes[i] & 0xFC) >> 2];
        outputBytes[outputLength++] = lookup[((inputBytes[i] & 0x03) << 4) | ((inputBytes[i + 1] & 0xF0) >> 4)];
        outputBytes[outputLength++] = lookup[(inputBytes[i + 1] & 0x0F) << 2];
        outputBytes[outputLength++] =   '=';
    }
    else if (i == inputLength - 1)
    {
        // == terminator
        outputBytes[outputLength++] = lookup[(inputBytes[i] & 0xFC) >> 2];
        outputBytes[outputLength++] = lookup[(inputBytes[i] & 0x03) << 4];
        outputBytes[outputLength++] = '=';
        outputBytes[outputLength++] = '=';
    }
    
    
    NSData * data_result=nil;
    
    if (outputLength >= 4)
    {
        //truncate data to match actual output length
        outputBytes = realloc(outputBytes,(unsigned long)outputLength);
        
        data_result=[NSData dataWithBytes:outputBytes length:(NSInteger)outputLength];
        /*return [[NSString alloc] initWithBytesNoCopy:outputBytes
         length:outputLength
         encoding:NSASCIIStringEncoding
         freeWhenDone:YES];*/
    }
  
    free(outputBytes);
    return data_result;
    
    
}
- (NSData *)base64Decoded_Ext
{
    
    const char lookup[] =
    {
        99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
        99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
        99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 62, 99, 99, 99, 63,
        52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 99, 99, 99, 99, 99, 99,
        99,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
        15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 99, 99, 99, 99, 99,
        99, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
        41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 99, 99, 99, 99, 99
    };
    
    //NSData *inputData = [string dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    long long inputLength = [self length];
    const unsigned char *inputBytes = [self bytes];
    
    long long maxOutputLength = (inputLength / 4 + 1) * 3;
    NSMutableData *outputData = [NSMutableData dataWithLength:(NSInteger)maxOutputLength];
    unsigned char *outputBytes = (unsigned char *)[outputData mutableBytes];
    
    int accumulator = 0;
    long long outputLength = 0;
    unsigned char accumulated[] = {0, 0, 0, 0};
    for (long long i = 0; i < inputLength; i++)
    {
        unsigned char decoded = lookup[inputBytes[i] & 0x7F];
        if (decoded != 99)
        {
            accumulated[accumulator] = decoded;
            if (accumulator == 3)
            {
                outputBytes[outputLength++] = (accumulated[0] << 2) | (accumulated[1] >> 4);
                outputBytes[outputLength++] = (accumulated[1] << 4) | (accumulated[2] >> 2);
                outputBytes[outputLength++] = (accumulated[2] << 6) | accumulated[3];
            }
            accumulator = (accumulator + 1) % 4;
        }
    }
    
    //handle left-over data
    if (accumulator > 0) outputBytes[outputLength] = (accumulated[0] << 2) | (accumulated[1] >> 4);
    if (accumulator > 1) outputBytes[++outputLength] = (accumulated[1] << 4) | (accumulated[2] >> 2);
    if (accumulator > 2) outputLength++;
    
    //truncate data to match actual output length
    outputData.length = (NSInteger) outputLength;
        
    return outputLength? outputData: nil;
}



+ (NSData *)dataFromBase64String_Ext:(NSString *)aString encoding:(NSStringEncoding)encode
{
	NSData *data = [aString dataUsingEncoding:encode];
	
    NSData * result=[data base64Decoded_Ext];
	return result;
}


- (NSString *)base64EncodedStringEncoding_Ext:(NSStringEncoding)encoding
{

    NSData * data=[self base64Encoded_Ext];
   __autoreleasing  NSString * result=[[NSString alloc] initWithData:data encoding:encoding];
	return result;
}

- (NSString *)base64DecodedStringEncoding_Ext:(NSStringEncoding)encoding
{

    NSData * data=[self base64Decoded_Ext];
   __autoreleasing NSString * result=[[NSString alloc] initWithData:data encoding:encoding];
    return result;
}

- (NSData *)dataUsingAES128EncryptWithkey_Ext:(NSData *)keyData withIV:(void *)iv_
{
    if (self==nil) {
        return nil;
    }
   
    return [self cipherData:self withkey:keyData withIV:iv_ Operation:kCCEncrypt Algorithm:kCCAlgorithmAES128 keySize:kCCKeySizeAES128 options:kCCOptionPKCS7Padding];
    
}
- (NSData *)dataUsingAES128DecryptWithkey_Ext:(NSData *)keyData withIV:(void *)iv_
{
    if (self==nil) {
        return nil;
    }
    return [self cipherData:self withkey:keyData withIV:iv_ Operation:kCCDecrypt Algorithm:kCCAlgorithmAES128 keySize:kCCKeySizeAES128 options:kCCOptionPKCS7Padding];

}
- (NSData *)dataUsingAES256EncryptWithkey_Ext:(NSData *)keyData withIV:(void *)iv_
{

    if (self==nil) {
        return nil;
    }
    
    return [self cipherData:self withkey:keyData withIV:iv_ Operation:kCCEncrypt Algorithm:kCCAlgorithmAES128 keySize:kCCKeySizeAES256 options:kCCOptionPKCS7Padding];


}

- (NSData *)dataUsingAES256DecryptWithkey_Ext:(NSData *)keyData withIV:(void *)iv_
{
    if (self==nil) {
        return nil;
    }
    
    return [self cipherData:self withkey:keyData withIV:iv_ Operation:kCCDecrypt Algorithm:kCCAlgorithmAES128 keySize:kCCKeySizeAES256 options:kCCOptionPKCS7Padding];

    
}




- (NSData *)dataUsing3DESEncryptWithkey_Ext:(NSData *)keyData withIV:(void *)iv_
{

    if (self==nil) {
        return nil;
    }
    
    return [self cipherData:self withkey:keyData withIV:iv_ Operation:kCCEncrypt Algorithm:kCCAlgorithm3DES keySize:kCCKeySize3DES options:kCCOptionPKCS7Padding];
    
}
- (NSData *)dataUsing3DESDecryptWithkey_Ext:(NSData *)keyData withIV:(void *)iv_
{

    if (self==nil) {
        return nil;
    }
    return [self cipherData:self withkey:keyData withIV:iv_ Operation:kCCDecrypt Algorithm:kCCAlgorithm3DES keySize:kCCKeySize3DES options:kCCOptionPKCS7Padding];

}

- (NSData *)dataUsingDESEncryWithkey_Ext:(NSData *)keyData withIV:(void *)iv_
{

    if (self==nil) {
        return nil;
    }
    
    return [self cipherData:self withkey:keyData withIV:iv_ Operation:kCCEncrypt Algorithm:kCCAlgorithmDES keySize:kCCKeySizeDES options:kCCOptionPKCS7Padding];
    
}

- (NSData *)dataUsingDESDencryWithkey_Ext:(NSData *)keyData withIV:(void *)iv_
{
    if (self==nil) {
        return nil;
    }
    return [self cipherData:self withkey:keyData withIV:iv_ Operation:kCCDecrypt Algorithm:kCCAlgorithmDES keySize:kCCKeySizeDES options:kCCOptionPKCS7Padding];
}


+(NSData *)cipherData_Ext:(NSData *)edata withkey:(NSData *)kData withIV:(void *)iv_byte  Operation:(CCOperation)operation Algorithm:(CCAlgorithm)algorithm keySize:(uint8_t)keySize options:(CCOptions)options
{
    return [[self class] cipherData:edata withkey:kData withIV:iv_byte Operation:operation Algorithm:algorithm keySize:keySize options:options];
}


-(NSData *)cipherData:(NSData *)edata withkey:(NSData *)kData withIV:(void *)iv_byte  Operation:(CCOperation)operation Algorithm:(CCAlgorithm)algorithm keySize:(uint8_t)keySize options:(CCOptions)options
{
    
    const void *textBytes = [edata bytes];//需要加密的bytes
    NSUInteger dataLength = [edata length];//
    
    const void * vkey = (const void *)[kData bytes];
    
    size_t numBytesEncrypted = 0;
    
    
    int blockSize=8;//设置blockSize的大小如:kCCBlockSizeDES
    if (algorithm==kCCAlgorithmAES128) {//如果是AES的时候 kCCBlockSizeAES128=16
        blockSize=16;
    }
    
    uint8_t * bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    bufferPtrSize = (dataLength +blockSize ) & ~(blockSize - 1);//
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    CCCryptorStatus cryptStatus = CCCrypt(operation, algorithm,
                                          options,
                                          vkey, keySize,
                                          iv_byte,
                                          textBytes, dataLength,
                                          (void *)bufferPtr,
                                          bufferPtrSize,
                                          &numBytesEncrypted);
    
    NSData *data=nil;
    if (cryptStatus == kCCSuccess) {
        data= [NSData dataWithBytes:bufferPtr length:(NSUInteger)numBytesEncrypted];
    }
    free(bufferPtr);
    
    return data;    
    
}



- (id)objectFromJSONData_Ext
{

    if (self==nil) {
        return nil;
    }
    
    id obj=nil;
    NSError * error=nil;
    NSException * excp=nil;
    @try {
        obj=[NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:&error];
    }
    @catch (NSException *exception) {
        excp=exception;
    }
    @finally {
        
    }
    
    if (error||excp) {
        //@throw excp;
        return nil;
    }
    
    return obj;
    
}




//gzip压缩
+(NSData*) gzipData_Ext: (NSData*)pUncompressedData
{
    if (!pUncompressedData || [pUncompressedData length] == 0)
    {
        kExtLog(@"%s: Error: Can't compress an empty or null NSData object.", __func__);
        return nil;
    }
    
    z_stream zlibStreamStruct;
    zlibStreamStruct.zalloc    = Z_NULL; // Set zalloc, zfree, and opaque to Z_NULL so
    zlibStreamStruct.zfree     = Z_NULL; // that when we call deflateInit2 they will be
    zlibStreamStruct.opaque    = Z_NULL; // updated to use default allocation functions.
    zlibStreamStruct.total_out = 0; // Total number of output bytes produced so far
    zlibStreamStruct.next_in   = (Bytef*)[pUncompressedData bytes]; // Pointer to input bytes
    zlibStreamStruct.avail_in  = (uInt)[pUncompressedData length]; // Number of input bytes left to process
    
    int initError = deflateInit2(&zlibStreamStruct, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY);
    if (initError != Z_OK)
    {
        NSString *errorMsg = nil;
        switch (initError)
        {
            case Z_STREAM_ERROR:
                errorMsg = @"Invalid parameter passed in to function.";
                break;
            case Z_MEM_ERROR:
                errorMsg = @"Insufficient memory.";
                break;
            case Z_VERSION_ERROR:
                errorMsg = @"The version of zlib.h and the version of the library linked do not match.";
                break;
            default:
                errorMsg = @"Unknown error code.";
                break;
        }
        kExtLog(@"%s: deflateInit2() Error: \"%@\" Message: \"%s\"", __func__, errorMsg, zlibStreamStruct.msg);
        return nil;
    }
    
    // Create output memory buffer for compressed data. The zlib documentation states that
    // destination buffer size must be at least 0.1% larger than avail_in plus 12 bytes.
    NSMutableData *compressedData = [NSMutableData dataWithLength:[pUncompressedData length] * 1.01 + 12];
    
    int deflateStatus;
    do
    {
        // Store location where next byte should be put in next_out
        zlibStreamStruct.next_out = [compressedData mutableBytes] + zlibStreamStruct.total_out;
        
        // Calculate the amount of remaining free space in the output buffer
        // by subtracting the number of bytes that have been written so far
        // from the buffer's total capacity
        zlibStreamStruct.avail_out =(uInt) ([compressedData length] - zlibStreamStruct.total_out);
        deflateStatus = deflate(&zlibStreamStruct, Z_FINISH);
        
    } while ( deflateStatus == Z_OK );
    
    // Check for zlib error and convert code to usable error message if appropriate
    if (deflateStatus != Z_STREAM_END)
    {
        NSString *errorMsg = nil;
        switch (deflateStatus)
        {
            case Z_ERRNO:
                errorMsg = @"Error occured while reading file.";
                break;
            case Z_STREAM_ERROR:
                errorMsg = @"The stream state was inconsistent (e.g., next_in or next_out was NULL).";
                break;
            case Z_DATA_ERROR:
                errorMsg = @"The deflate data was invalid or incomplete.";
                break;
            case Z_MEM_ERROR:
                errorMsg = @"Memory could not be allocated for processing.";
                break;
            case Z_BUF_ERROR:
                errorMsg = @"Ran out of output buffer for writing compressed bytes.";
                break;
            case Z_VERSION_ERROR:
                errorMsg = @"The version of zlib.h and the version of the library linked do not match.";
                break;
            default:
                errorMsg = @"Unknown error code.";
                break;
        }
        kExtLog(@"%s: zlib error while attempting compression: \"%@\" Message: \"%s\"", __func__, errorMsg, zlibStreamStruct.msg);
        
        // Free data structures that were dynamically created for the stream.
        deflateEnd(&zlibStreamStruct);
        
        return nil;
    }
    // Free data structures that were dynamically created for the stream.
    deflateEnd(&zlibStreamStruct);
    [compressedData setLength: zlibStreamStruct.total_out];
    // NSLog(@"%s: Compressed file from %d KB to %d KB", __func__, [pUncompressedData length]/1024, [compressedData length]/1024);
    
    return compressedData;
}

//gzip解压
+(NSData *)ungzipData_Ext:(NSData *)compressedData
{
    if ([compressedData length] == 0)
        return compressedData;
    
    unsigned full_length =(unsigned) [compressedData length];
    unsigned half_length =(unsigned)[compressedData length] / 2;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength: full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[compressedData bytes];
    strm.avail_in = (uInt) [compressedData length];
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    if (inflateInit2(&strm, (15+32)) != Z_OK)
        return nil;
    
    while (!done) {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length]) {
            [decompressed increaseLengthBy: half_length];
        }
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out =(uInt) ([decompressed length] - strm.total_out);
        // Inflate another chunk.
        status = inflate (&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) {
            done = YES;
        } else if (status != Z_OK) {
            break;
        }
    }
    
    if (inflateEnd (&strm) != Z_OK)
        return nil;
    // Set real length.
    if (done) {
        [decompressed setLength: strm.total_out];
        return [NSData dataWithData: decompressed];
    }
    return nil;
}


- (NSData *)gzipData_Ext
{
    return [NSData gzipData_Ext:self];
}

- (NSData *)ungzipData_Ext
{
    return [NSData ungzipData_Ext:self];
}





@end
