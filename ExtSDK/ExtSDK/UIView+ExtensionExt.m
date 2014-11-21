//  UIView+ExtensionExt.m
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



#import "UIView+ExtensionExt.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (ExtensionExt)

- (CGFloat)frameX_Ext;
{
    return self.frame.origin.x;
}
- (CGFloat)frameY_Ext
{
    return self.frame.origin.y;
}
- (CGFloat)frameWidth_Ext
{
    return self.frame.size.width;
}

- (CGFloat)frameHeight_Ext
{
    return self.frame.size.height;
}




- (UIImage *)screenshot_Ext
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0)
    {
      
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return screenshot;
    }
    else{
      UIGraphicsBeginImageContext(self.bounds.size);
      [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
      UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
      
      return image;
    }
    
}


- (UIView *)currentFirstResponderView_Ext
{
    if (self.isFirstResponder) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView currentFirstResponderView_Ext];
        if (firstResponder != nil) {
            return firstResponder;
        }
       
    }
    
    return nil;
}





@end



