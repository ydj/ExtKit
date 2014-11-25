//  NSObject+ExtensionExt.m
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



#import "NSObject+ExtensionExt.h"
#import "NSString+ExtensionExt.h"
#import <objc/runtime.h>

@implementation NSObject (ExtensionExt)


-(void)setUserInfo_Ext:(NSDictionary *)newUserInfo_Ext
{
    objc_setAssociatedObject(self, @"userInfo_Ext", newUserInfo_Ext, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)userInfo_Ext
{
    return objc_getAssociatedObject(self, @"userInfo_Ext");
}


- (BOOL)encoderObject_Ext:(id)obj withPath:(NSString *)path_
{
    
    if ( obj &&![obj conformsToProtocol:@protocol(NSCoding)]) {

        return NO;
    }
    
    NSString * extPath=[path_ stringByDeletingLastPathComponent];
    NSString * docName=[path_ lastPathComponent];
    if (![[NSFileManager defaultManager] fileExistsAtPath:extPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:extPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    NSMutableData * data=[NSMutableData data];
    NSKeyedArchiver * archiver=[[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:obj
                    forKey:[docName md5DHexDigestString_Ext]];
    [archiver finishEncoding];
    
    BOOL isResult=NO;

    if ([data respondsToSelector:@selector(writeToFile:atomically:)]) {
        isResult=[data writeToFile:path_ atomically:YES];
    }
    
    return isResult;
    
}

- (id)decoderObjectPath_Ext:(NSString *)path_
{

    NSFileManager * file=[NSFileManager defaultManager];
    
    if ([file fileExistsAtPath:path_]==NO) {
        return nil;
    }
    NSArray * array=[path_ componentsSeparatedByString:@"/"];
    if ([array count]==0) {
        return nil;
    }
    NSData * data=[[NSMutableData alloc] initWithContentsOfFile:path_];
    NSKeyedUnarchiver * unarchiver=[[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id obj=[unarchiver decodeObjectForKey:[[array lastObject] md5DHexDigestString_Ext]];
    [unarchiver finishDecoding];
    return obj;
}


-(void)writeToFile_Ext:(NSString *)path data:(NSData *)data
{//数据写到本地
    if (path==nil||data==nil) {
        return ;
    }
    
    NSString * extPath=[path stringByDeletingLastPathComponent];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:extPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:extPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if ([data respondsToSelector:@selector(writeToFile:atomically:)]) {
        [data writeToFile:path atomically:YES];
    }

}



- (NSDictionary*)getDictionaryFromObject_Ext:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++) {
        objc_property_t prop = props[i];
        id value = nil;
        
        @try {
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
            value = [self getObjectInternal_Ext:[obj valueForKey:propName]];
            if(value != nil) {
                [dic setObject:value forKey:propName];
            }
        }
        @catch (NSException *exception) {
        }
        
    }
    free(props);
    return dic;
}

- (NSData*)getJSON_Ext:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error
{
    return [NSJSONSerialization dataWithJSONObject:[self getDictionaryFromObject_Ext:obj] options:options error:error];
}

- (id)getObjectInternal_Ext:(id)obj
{
    if(!obj
       || [obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]]) {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]]) {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++) {
            [arr setObject:[self getObjectInternal_Ext:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys) {
            [dic setObject:[self getObjectInternal_Ext:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getDictionaryFromObject_Ext:obj];
}



@end
