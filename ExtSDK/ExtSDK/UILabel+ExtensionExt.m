//  UILabel+ExtensionExt.m
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



#import "UILabel+ExtensionExt.h"

@implementation UILabel (ExtensionExt)


- (CGSize)fitTextHeight_Ext
{
    CGSize size=CGSizeMake(self.bounds.size.width, NSIntegerMax);
    
    return [self contentSizeWithSize:size];
}

- (CGSize)fitTextWidth_Ext
{
    CGSize size=CGSizeMake( NSIntegerMax,self.bounds.size.height);
    
    return [self contentSizeWithSize:size];
}

- (CGSize)contentSizeWithSize:(CGSize)sizet {
    
    
#ifndef __IPHONE_7_0
#define __IPHONE_7_0     70000
#endif
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0)
    {
        
        CGSize size=[self.text sizeWithFont:self.font constrainedToSize:sizet lineBreakMode:self.lineBreakMode];
        return size;
    }
    else{
        
        /*
         NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
         paragraphStyle.lineBreakMode = self.lineBreakMode;
         paragraphStyle.alignment = self.textAlignment;
         */
        NSDictionary * attributes = @{NSFontAttributeName : self.font,
                                      };///NSParagraphStyleAttributeName : paragraphStyle
        
        CGSize contentSize = [self.text boundingRectWithSize:sizet
                                                     options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                  attributes:attributes
                                                     context:nil].size;
        return contentSize;
        
        
    }
#else
    NSDictionary * attributes = @{NSFontAttributeName : self.font,
                                  };///NSParagraphStyleAttributeName : paragraphStyle
    
    CGSize contentSize = [self.text boundingRectWithSize:sizet
                                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              attributes:attributes
                                                 context:nil].size;
    return contentSize;
    
#endif
    
    
    
    
  
}

@end
