//  LanguageExt.m
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


#import "LanguageExt.h"

NSString *ESLocalFileName_Language=@"Localization";
NSString * const ESLocalLanguageDidChangeNotification = @"ESLocalLanguageDidChangeNotification";

@implementation LanguageExt
static  NSBundle *bundle = nil;
static  NSString * labguageString=nil;

+(void)initialize {
    if (ESLocalFileName_Language.length==0) {
        ESLocalFileName_Language=@"Localization";
    }
    NSArray* languages = [NSLocale preferredLanguages];
    __strong  NSString *current = [languages objectAtIndex:0];
    [self setLanguage:current];
    
}

/*
 example calls:
 [Language setLanguage:@"it"];
 [Language setLanguage:@"de"];
 */
+(void)setLanguage:(NSString *)l {
   
    BOOL isHave=NO;
    
    NSFileManager * manager=[NSFileManager defaultManager];
    
    if (l.length>0) {
        NSString *path = [[ NSBundle mainBundle ] pathForResource:l ofType:@"lproj" ];
        if ([manager fileExistsAtPath:path]) {
            isHave=YES;
            labguageString=nil;
            bundle=nil;
            labguageString=[[NSString  alloc]initWithFormat:@"%@",l];
            bundle=[[NSBundle alloc]initWithPath:path];
        }
    }
    
    
    if (isHave==NO) {
    
        NSArray* languages = [NSLocale preferredLanguages];
        NSString *current = [languages objectAtIndex:0];
        NSString * testPath=[[ NSBundle mainBundle ] pathForResource:current ofType:@"lproj" ];
        if ([manager fileExistsAtPath:testPath]==NO) {
            current=@"en";
            testPath=[[NSBundle mainBundle] pathForResource:current ofType:@"lproj"];
        }
        labguageString=nil;
        bundle=nil;
        labguageString=[[NSString alloc]initWithFormat:@"%@",current];
        bundle=[[NSBundle alloc]initWithPath:testPath];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ESLocalLanguageDidChangeNotification object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"CurrentLanguage",labguageString, nil]];
    
}
+(NSString *)getCurrentLanguageStringWithLocal
{
    if (labguageString==nil||labguageString.length==0 ) {
        [self initialize];
    }
    return labguageString;
}
+(NSString *)getLocalizedString:(NSString *)key alter:(NSString *)alternate{
    if (bundle==nil) {
        [self initialize];
    }
    if (ESLocalFileName_Language.length==0) {
        ESLocalFileName_Language=@"Localization";
    }
    return  NSLocalizedStringFromTableInBundle(key, ESLocalFileName_Language, bundle, alternate);
}

+(NSString *)localizedStringWithKey:(NSString *)key withAlter:(NSString *)alternate
{
    if (bundle==nil) {
        [self initialize];
    }
    return NSLocalizedStringFromTableInBundle(key, @"Localization", bundle, alternate);
}
@end
