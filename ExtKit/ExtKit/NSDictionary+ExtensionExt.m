//  NSDictionary+ExtensionExt.m
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



#import "NSDictionary+ExtensionExt.h"

@implementation NSDictionary (ExtensionExt)


- (NSData *)JSONData_Ext
{

//    if (![NSJSONSerialization isValidJSONObject:self]) {
//        return nil;
//    }
    NSError * error=nil;
    NSData * data=nil;
    NSException * exce=nil;
    @try {
        ///这里的options参数为kNilOptions,转换为json的时候不添加\n格式化换行
        ///当该参数为NSJSONWritingPrettyPrinted时，添加\n格式化换行，方便阅读
        data= [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    }
    @catch (NSException *exception) {
        exce=exception;
    }
    @finally {
        
    }
    
    if (error || exce) {
        return nil;
    }

    return data;
    
}

- (NSString *)JSONString_Ext
{

    NSData * data=[self JSONData_Ext];
    if (data) {
     __autoreleasing NSString *  string=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return string;
    }
    return nil;
}

@end
