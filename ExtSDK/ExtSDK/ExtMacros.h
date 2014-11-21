//  ExtMacros.h
//
//  Copyright (c) 2014 YDJ (https://github.com/ydj/ExtSDK)
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

#ifndef ExtensionSDK_ExtMacros_h
#define ExtensionSDK_ExtMacros_h

///是否打印log
#define kLogEnable_Ext 0

#if kLogEnable_Ext
#define kExtLog(...) NSLog(__VA_ARGS__)
#else
#define kExtLog(...) nil
#endif


#ifndef kLibraryCaches_Ext
#define kLibraryCaches_Ext [NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()]
#endif

#ifndef kCachesDocument_Ext
#define kCachesDocument_Ext [NSString stringWithFormat:@"%@/CachesDocument",kLibraryCaches_Ext]
#endif

#ifndef kCrashLogPath_Ext
#define kCrashLogPath_Ext [NSString stringWithFormat:@"/%@/kCrashLog",kCachesDocument_Ext]
#endif




#endif
