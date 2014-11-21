//  UIDevice+ExtensionExt.m
//
//  Copyright (c) 2014 YDJ ( https://github.com/ydj/ExtSDK )
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



#import "UIDevice+ExtensionExt.h"
#import "NSString+ExtensionExt.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>


#include <sys/types.h>
#import "UIDevice+ExtensionExt.h"
#import "NSString+ExtensionExt.h"

@implementation UIDevice (ExtensionExt)

- (BOOL)is3_5Inch_Ext
{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO);
 
}

- (BOOL)_judegForSize:(CGSize)size
{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(size, [[UIScreen mainScreen] currentMode].size) : NO);
}

/**
 * @brief 判断设备是否是4寸
 *
 * @return YES 是，NO 不是
 */
- (BOOL)is4Inch_Ext
{
    return [self _judegForSize:CGSizeMake(640, 1136)];
}
- (BOOL)is4_7Inch_Ext
{
    return [self _judegForSize:CGSizeMake(750, 1334)];
}
- (BOOL)is5_5Inch_Ext
{
    return [self _judegForSize:CGSizeMake(1242, 2208)];
}

- (BOOL)isRetain_Ext
{
    
    CGSize size=[[UIScreen mainScreen] currentMode].size;
    if (CGSizeEqualToSize(size, CGSizeMake(320, 480)) ||CGSizeEqualToSize(size, CGSizeMake(768, 1024)) )
    {
        return NO;
    }
    return YES;
    
}

/**
 * @brief 设备是否越狱
 *
 * @return YES 越狱, NO 未越狱
 */
- (BOOL)isJailbroken_Ext
{
    BOOL jailbroken = NO;
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        jailbroken = YES;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        jailbroken = YES;
    }    
    return jailbroken;    
}



-(NSString*)getUUID_Ext
{
    CFUUIDRef puuid = CFUUIDCreate( kCFAllocatorDefault );
    CFStringRef uuidString = CFUUIDCreateString( kCFAllocatorDefault, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( kCFAllocatorDefault, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

-(NSString *)createUdidString_Ext
{//uuid+随机字符或数字 经过md5处理
    
    NSString * bundleId= [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    if (bundleId.length==0)
    {
        bundleId=@"comm.deviceid.tmp";
    }
    NSString * service=[bundleId stringByAppendingString:@".servise"];    NSString * account=[bundleId stringByAppendingString:@".account"];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:3];
    [dictionary setObject:(__bridge  id)kSecClassGenericPassword forKey:(__bridge  id)kSecClass];
    if (service) {
        [dictionary setObject:service forKey:(__bridge  id)kSecAttrService];
    }
    
    if (account) {
        [dictionary setObject:account forKey:(__bridge  id)kSecAttrAccount];
    }
    [dictionary setObject:(__bridge  id)kSecAttrAccessibleAlwaysThisDeviceOnly forKey:(__bridge  id)kSecAttrAccessible];
   
    ////获取
    NSMutableDictionary * tempDictionary=[NSMutableDictionary dictionaryWithDictionary:dictionary];
    OSStatus status;
    CFTypeRef resultData = NULL;
    [tempDictionary setObject:@YES forKey:(__bridge  id)kSecReturnData];
    [tempDictionary setObject:(__bridge  id)kSecMatchLimitOne forKey:(__bridge  id)kSecMatchLimit];
    status= SecItemCopyMatching((__bridge  CFDictionaryRef)tempDictionary, &resultData);
    NSData * data=(__bridge NSData *)resultData;
   __autoreleasing NSString * endid=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (resultData) {
        CFRelease(resultData);
    }
    
    if (endid.length==0) {
        NSMutableString * string=[[NSMutableString alloc] init];
        NSString * uuString=[self getUUID_Ext];
        [string appendFormat:@"%@-",uuString];//uuid
        
        for (int i=0; i<16; i++) {//随机数
            int num=arc4random()%10;
            if (num%2==0) {
                [string appendFormat:@"%d",arc4random()%10];
            }
            else{
                [string appendFormat:@"%c",65+arc4random()%26];
            }
          }
        string=(NSMutableString *)[string md5DHexDigestString_Ext];
        endid=string;
        [dictionary setObject:[endid dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge  id)kSecValueData];
        [dictionary setObject:@"label for device id" forKey:(__bridge  id)kSecAttrLabel];
        SecItemAdd((__bridge  CFDictionaryRef)dictionary, NULL);
        
      }
    
    return endid;
}
/**
 * @brief 获得设备的唯一标示
 *
 * @return 返回设备的唯一标示
 */
- (NSString *)udidString_Ext
{
   return  [self createUdidString_Ext];
}
/**
 * @brief 系统的进程
 *
 * @return 数组中有字典，返回进程的id和名称
 */
- (NSArray *)runningProcesses_Ext
{

        int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
        size_t miblen = 4;
        
        size_t size;
        int st = sysctl(mib,(u_int)miblen, NULL, &size, NULL, 0);
        
        struct kinfo_proc * process = NULL;
        struct kinfo_proc * newprocess = NULL;
        
        do {
            
            size += size / 10;
            newprocess = realloc(process, size);
            
            if (!newprocess){
                
                if (process){
                    free(process);
                }
                
                return nil;
            }
            
            process = newprocess;
            st = sysctl(mib, (u_int)miblen, process, &size, NULL, 0);
            
        } while (st == -1 && errno == ENOMEM);
        
        if (st == 0){
            
            if (size % sizeof(struct kinfo_proc) == 0){
                int nprocess = (int )(size / sizeof(struct kinfo_proc));
                
                if (nprocess){
                    
                  __autoreleasing  NSMutableArray * array = [[NSMutableArray alloc] init];
                    
                    for (int i = nprocess - 1; i >= 0; i--){
                        
                        NSString * processID = [NSString stringWithFormat:@"%d", process[i].kp_proc.p_pid];
                        NSString * processName = [NSString stringWithFormat:@"%s", process[i].kp_proc.p_comm];
                        
                        NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:processID, processName, nil]
                                                                            forKeys:[NSArray arrayWithObjects:@"ProcessID", @"ProcessName", nil]];
                        [array addObject:dict];
                    }
                    
                    free(process);  
                    return array;
                }  
            }  
        }  
        
        return nil;
}




- (NSString *)systemNameString_Ext
{
    NSString *infoString = [self systemName];//系统名称，如iPhone OS
    return infoString;
}

- (NSString *)systemVersionString_Ext
{
    NSString *infoString = [self systemVersion];//系统版本，如4.2.1
    return infoString;
}


- (NSString *)deviceNameString_Ext
{
    NSString *infoString = [self name];//设备的名称，如 张三的iPhone
    return infoString;
}

- (NSString *)localizedModelString_Ext
{
    NSString *infoString = [self localizedModel];//localized version of model
    return infoString;
}



#pragma mark -
#pragma mark Public Methods



#pragma mark sysctlbyname utils
- (NSString *) getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    //NSLog(@"%s",answer);
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    free(answer);
    return results;
}

- (NSString *) platform_Ext
{
    return [self getSysInfoByName:"hw.machine"];
}






@end
