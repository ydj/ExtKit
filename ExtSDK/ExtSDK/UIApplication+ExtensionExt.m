//  UIApplication+ExtensionExt.m
//
//  Copyright (c) 2014 NextDj (https://github.com/ydj/ExtSDK)
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



#import "UIApplication+ExtensionExt.h"
#import "ExtMacros.h"
#import "UIDevice+ExtensionExt.h"
#import "NSObject+ExtensionExt.h"
#import <objc/runtime.h>


const NSString * const kTopic_extension=@"comm.image.extension.topic_Ext";
NSString * const kTopicdidChangeNotification=@"kTopicdidChangeNotification";
NSString * const kCurrentTopicNotificationUserInfo=@"kCurrentTopicNotificationUserInfo";


BOOL isOpenCrashLog_Ext_private=NO;
NSString * crashLog_Ext_private=nil;

void installUncaughtExceptionHandler_Ext();

@implementation UIApplication (ExtensionExt)
@dynamic isOpenCrashLog_Ext;
@dynamic crashLogPath_Ext;

- (void)terminateWithException_Ext:(NSException*)exception
{
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSMutableString *messageStr = [[NSMutableString alloc] init];
    
    if (arr.count>0)
    {
        
        for (int i = 0; i<arr.count; i++)
        {
           
            if ([[arr objectAtIndex:i] isKindOfClass:[NSString class]])
            {
                
                NSString *str = [NSString stringWithFormat:@"%@\n",[arr objectAtIndex:i]];
                [messageStr appendFormat:@"%@\n",str];
            }
        }
        
    }else{
        
        return;
    }
    
    NSString *filePath =nil;
    if(crashLog_Ext_private.length==0){
        filePath=kCrashLogPath_Ext;
    }
    else{
        filePath=crashLog_Ext_private;
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        if (!bo) {
            NSAssert(bo,@"创建目录失败");
        }
    }
    
    UIDevice * device=[UIDevice currentDevice];
    NSString * yy=@"否";
    if ([device isJailbroken_Ext]) {
        yy=@"是";
    }
    NSString * ver=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString * shorTVersion=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //时间，系统版本,id,是否越狱,崩溃的名字原因，详细信息
    NSString *errStr = [NSString stringWithFormat:@"时间:%@\n程序版本:%@(%@)\n系统版本:%@\nid:%@\n是否越狱:%@\n崩溃信息:%@\n%@\n%@\n",[NSDate date],shorTVersion,ver,[device systemVersion],[device udidString_Ext],yy,name,reason,messageStr];
    NSString *writePath=[NSString stringWithFormat:@"%@/%@.txt",filePath,[NSDate date]];
    NSData *data = [errStr dataUsingEncoding:NSUTF8StringEncoding];//新文件的初始数据，设为空
    
    [data writeToFile_Ext:writePath data:data];//写到本地
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    
    
    BOOL boo = [[NSFileManager defaultManager] fileExistsAtPath:writePath];
  
    while (!boo)
    {
        for (NSString *mode in (__bridge NSArray *)allModes)
        {
            CFRunLoopRunInMode((__bridge CFStringRef)mode, 0.001, false);
        }
    }
    CFRelease(allModes);
    
}

- (void)setkCrashLogPath_Ext:(NSString *)crashLogPath_
{
    if (crashLogPath_.length>0) {
        crashLog_Ext_private=crashLogPath_;
        objc_setAssociatedObject(self, @"crashLogPath", crashLogPath_, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
}

- (NSString *)crashLogPath_Ext
{
    if (crashLog_Ext_private==nil) {
        return kCrashLogPath_Ext;
    }
    return crashLog_Ext_private;
}
/**
 *
 * @brief 是否打开崩溃记录，本地信息会写到本地的文件中,crashLogPath路径下
 *
 */
- (void)setIsOpenCrashLog_Ext:(BOOL)isOpenCrashLog_Ext_
{
    
    installUncaughtExceptionHandler_Ext();
    
    isOpenCrashLog_Ext_private=isOpenCrashLog_Ext_;
    objc_setAssociatedObject(self, @"isOpenCrashLog_Ext", [NSNumber numberWithBool:isOpenCrashLog_Ext_private], OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isIsOpenCrashLog_Ext
{
    return isOpenCrashLog_Ext_private;//[objc_getAssociatedObject(self, @"isOpenCrashLog_Ext") boolValue];
}


/**
 *	@brief	扩展图片/主题的名字,如果是默认主题就是返回@""
 */
- (void)setTopic_Ext:(NSString *)topic_Ext_
{//当前主题的扩展名字
    
    if (topic_Ext_==nil) {
        topic_Ext_=@"";
    }
    
    BOOL isE=NO;
    if ([self.topic_Ext isEqual:topic_Ext_]) {
        isE=YES;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:topic_Ext_ forKey:(NSString *)kTopic_extension];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (isE==NO) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kTopicdidChangeNotification object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:topic_Ext_,kCurrentTopicNotificationUserInfo, nil]];
    }
    
}
-(NSString *)topic_Ext
{
    NSString * top=[[NSUserDefaults standardUserDefaults] objectForKey:(NSString *)kTopic_extension];
    if (top==nil) {
        top=@"";
    }
    
    return top;
}



-(void)hiddenKeyBorad:(id)sedner
{//取消键盘的方法
    //objc_setAssociatedObject
    // objc_getAssociatedObject
    UIWindow * keyWindow=[[UIApplication sharedApplication] keyWindow];
    [keyWindow endEditing:YES];
    
}
-(void)keyBoradShow:(NSNotification *)notification
{//键盘通知触发的方法
    
    NSValue * value=[notification.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] ;
    CGRect lastRect=[value CGRectValue];
    
    UIWindow * _myWindow=[[[UIApplication sharedApplication] delegate] window];
    
    UIView * vBtn=[_myWindow viewWithTag:-200];
    if (vBtn) {
        [vBtn removeFromSuperview];
        vBtn=nil;
    }
    
    if (self.HiddenKeyBoardButton_Ext==NO) {
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag=-200;
        
        
        [btn setFrame:CGRectMake(self.hiddenKeyBoardButtonoffset_Ext.x,lastRect.origin.y+self.hiddenKeyBoardButtonoffset_Ext.y, 44, 45)];
        [btn setBackgroundImage:self.hiddenKeyBoardButtonImage_Ext forState:UIControlStateNormal];
        if (self.hiddenKeyBoardButtonImageHighlighted_Ext) {
            [btn setBackgroundImage:self.hiddenKeyBoardButtonImageHighlighted_Ext forState:UIControlStateHighlighted];
        }
        [btn addTarget:self action:@selector(hiddenKeyBorad:) forControlEvents:UIControlEventTouchUpInside];
        [_myWindow addSubview:btn];
    }
    
    
    
}

-(void)keyBoradHidden:(NSNotification *)notification
{
    UIWindow * _myWindow=[[[UIApplication sharedApplication] delegate] window];
    
    UIView * vBtn=[_myWindow viewWithTag:-200];
    [vBtn removeFromSuperview];
    vBtn=nil;
}

bool _HiddenKeyBoardButton_Ext=YES;


- (void)setHiddenKeyBoardButtonoffset_Ext:(CGPoint)hiddenKeyBoardButtonoffset_Ext
{
    objc_setAssociatedObject(self, @"hiddenKeyBoardButtonoffset_Ext", [NSValue valueWithCGPoint:hiddenKeyBoardButtonoffset_Ext], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGPoint )hiddenKeyBoardButtonoffset_Ext
{
    NSValue * value= objc_getAssociatedObject(self, @"hiddenKeyBoardButtonoffset_Ext");
    return  [value CGPointValue];
}

- (void)setHiddenKeyBoardButtonImageHighlighted_Ext:(UIImage *)hiddenKeyBoardButtonImageHighlighted_Ext
{
    objc_setAssociatedObject(self, @"hiddenKeyBoardButtonImageHighlighted_Ext", hiddenKeyBoardButtonImageHighlighted_Ext, OBJC_ASSOCIATION_RETAIN);
    
}

- (UIImage *)hiddenKeyBoardButtonImageHighlighted_Ext
{
    return objc_getAssociatedObject(self, @"hiddenKeyBoardButtonImageHighlighted_Ext");
}

- (void)setHiddenKeyBoardButtonImage_Ext:(UIImage *)hiddenKeyBoardButtonImage
{
    objc_setAssociatedObject(self, @"hiddenKeyBoardButtonImage_Ext", hiddenKeyBoardButtonImage, OBJC_ASSOCIATION_RETAIN);
}
- (UIImage*)hiddenKeyBoardButtonImage_Ext
{
    return objc_getAssociatedObject(self, @"hiddenKeyBoardButtonImage_Ext");
}

-(void)setHiddenKeyBoardButton_Ext:(BOOL)_hidden
{
    _HiddenKeyBoardButton_Ext=_hidden;
    if (!_hidden) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoradShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoradHidden:) name:UIKeyboardWillHideNotification object:nil];
    }
    else{
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
}
-(BOOL)HiddenKeyBoardButton_Ext
{
    return _HiddenKeyBoardButton_Ext;
}





-(NSString *)getBundleShortVersionString_Ext
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

-(NSString *)getBundleVersion_Ext
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

@end


///
/**
 * 设置打印崩溃信息的C方法
 */

void exceptionHandler_Ext(NSException *exception)
{
    if (isOpenCrashLog_Ext_private) {
        id delegate = [UIApplication sharedApplication] ;
        if([delegate respondsToSelector:@selector(terminateWithException_Ext:)])
        {
            [delegate performSelector:@selector(terminateWithException_Ext:) withObject:exception];
        }
    }
}
void signalHandler_Ext(int sig, siginfo_t *info, void *context)
{
    
    // signal exception
    NSException *e = [NSException exceptionWithName:@"signal exception"
                      
                                             reason:[NSString stringWithFormat:@"signal %d", sig]
                      
                                           userInfo:nil];
    
    exceptionHandler_Ext(e);
    
}
void installUncaughtExceptionHandler_Ext()
{
    NSSetUncaughtExceptionHandler(&exceptionHandler_Ext);
    
    // For signals
    
    struct sigaction sigAction;
    
    sigAction.sa_sigaction = signalHandler_Ext;
    
    sigAction.sa_flags = SA_SIGINFO;
    
    sigemptyset(&sigAction.sa_mask);
    
    sigaction(SIGQUIT, &sigAction, NULL);
    
    sigaction(SIGILL, &sigAction, NULL);
    
    sigaction(SIGTRAP, &sigAction, NULL);
    
    sigaction(SIGABRT, &sigAction, NULL);
    
    sigaction(SIGEMT, &sigAction, NULL);
    
    sigaction(SIGFPE, &sigAction, NULL);
    
    sigaction(SIGBUS, &sigAction, NULL);
    
    sigaction(SIGSEGV, &sigAction, NULL);
    
    sigaction(SIGSYS, &sigAction, NULL);
    
    sigaction(SIGPIPE, &sigAction, NULL);
    
    sigaction(SIGALRM, &sigAction, NULL);
    
    sigaction(SIGXCPU, &sigAction, NULL);
    
    sigaction(SIGXFSZ, &sigAction, NULL);
}



