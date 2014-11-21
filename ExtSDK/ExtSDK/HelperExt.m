//  CommonExt.m
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



#import "HelperExt.h"

@implementation HelperExt


+(NSString*)getUUID_Ext
{
    CFUUIDRef puuid = CFUUIDCreate( kCFAllocatorDefault );
    CFStringRef uuidString = CFUUIDCreateString( kCFAllocatorDefault, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( kCFAllocatorDefault, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

+(NSString *)getRandomNumberwithLength_Ext:(int)length
{
    if (length==0 ||length<0)
    {
        return nil;
    }
    NSMutableString * result=[NSMutableString string];
    
    for (int i=0; i<length; i++)
    {
        if (i==0)
        {
            [result appendFormat:@"%d",arc4random()%9+1];
        }
        else{
            [result appendFormat:@"%d",arc4random()%10];
        }
    }
    
    return result;
}

+(NSString *)getRandomStringwithLength_Ext:(int)length
{
    
    if (length==0 ||length<0)
    {
        return nil;
    }
    NSMutableString * result=[NSMutableString string];
    
    for (int i=0; i<length; i++)
    {
        if ((arc4random()%2+1)%2==0)
        {
            [result appendFormat:@"%c",arc4random()%26+97];
        }
        else{
            [result appendFormat:@"%c",arc4random()%26+65];
        }
    }
    
    return result;
}

+(NSString *)getRandomNumberAndStringWithLength_Ext:(int)length
{
    if (length==0 ||length<0)
    {
        return nil;
    }
    NSMutableString * result=[NSMutableString string];
    
    for (int i=0; i<length; i++)
    {
        if ((arc4random()%3+1)==1)
        {
            [result appendFormat:@"%c",arc4random()%26+97];
        }
        else if ((arc4random()%3+1)==1)
        {
            [result appendFormat:@"%c",arc4random()%26+65];
        }
        else{
            [result appendFormat:@"%d",arc4random()%10];
        }
    }
    
    return result;
}


@end
