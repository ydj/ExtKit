//  UIColor+ExtensionExt.m
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



#import "UIColor+ExtensionExt.h"

const NSInteger MAX_RGB_COLOR_VALUE = 0xff;
const NSInteger MAX_RGB_COLOR_VALUE_FLOAT = 255.0f;

@implementation UIColor (ExtensionExt)


/**
 * @brief 字符串中得到颜色值
 *
 * @param stringToConvert 字符串的值 e.g:@"#FF4500"
 *
 * @return 返回颜色对象
 */
+ (UIColor *)colorFromString_Ext:(NSString *)stringToConvert {
   
    return [self colorWithHexString_Ext:stringToConvert];
}



+ (UIColor *) colorWithRGBA_Ext:(uint) hex {
	return [UIColor colorWithRed:(CGFloat)((hex>>24) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
						   green:(CGFloat)((hex>>16) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
							blue:(CGFloat)((hex>>8) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
						   alpha:(CGFloat)((hex) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT];
}

+ (UIColor *) colorWithARGB_Ext:(uint) hex {
	return [UIColor colorWithRed:(CGFloat)((hex>>16) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
						   green:(CGFloat)((hex>>8) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
							blue:(CGFloat)(hex & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
						   alpha:(CGFloat)((hex>>24) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT];
}

+ (UIColor *) colorWithRGB_Ext:(uint) hex {
	return [UIColor colorWithRed:(CGFloat)((hex>>16) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
						   green:(CGFloat)((hex>>8) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
							blue:(CGFloat)(hex & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
						   alpha:1.0];
}


+ (UIColor *)colorWithHexString_Ext:(NSString *)hexString {
	uint hex;
	
	// chop off hash
	if ([hexString characterAtIndex:0] == '#') {
		hexString = [hexString substringFromIndex:1];
	}
	
	// depending on character count, generate a color
	NSInteger hexStringLength = hexString.length;
	
	if (hexStringLength == 3) {
		// RGB, once character each (each should be repeated)
		hexString = [NSString stringWithFormat:@"%c%c%c%c%c%c", [hexString characterAtIndex:0], [hexString characterAtIndex:0], [hexString characterAtIndex:1], [hexString characterAtIndex:1], [hexString characterAtIndex:2], [hexString characterAtIndex:2]];
		hex = (uint) strtoul([hexString UTF8String], NULL, 16);
        
		return [self colorWithRGB_Ext:hex];
	} else if (hexStringLength == 4) {
		// RGBA, once character each (each should be repeated)
		hexString = [NSString stringWithFormat:@"%c%c%c%c%c%c%c%c", [hexString characterAtIndex:0], [hexString characterAtIndex:0], [hexString characterAtIndex:1], [hexString characterAtIndex:1], [hexString characterAtIndex:2], [hexString characterAtIndex:2], [hexString characterAtIndex:3], [hexString characterAtIndex:3]];
		hex = (uint)strtoul([hexString UTF8String], NULL, 16);
        
		return [self colorWithRGBA_Ext:hex];
	} else if (hexStringLength == 6) {
		// RGB
		hex = (uint)strtoul([hexString UTF8String], NULL, 16);
		
		return [self colorWithRGB_Ext:hex];
	} else if (hexStringLength == 8) {
		// RGBA
		hex =(uint) strtoul([hexString UTF8String], NULL, 16);
        
		return [self colorWithRGBA_Ext:hex];
	}
	
	// illegal
	[NSException raise:@"Invalid Hex String" format:@"Hex string invalid: %@", hexString];
	
	return nil;
}

- (NSString *) hexString_Ext {
    
	const CGFloat *components = CGColorGetComponents(self.CGColor);
	
	int red = (int)(components[0] * MAX_RGB_COLOR_VALUE);
	int green = (int)(components[1] * MAX_RGB_COLOR_VALUE);
	int blue = (int)(components[2] * MAX_RGB_COLOR_VALUE);
	int alpha = (int)(components[3] * MAX_RGB_COLOR_VALUE);
	
	if (alpha < 255) {
		return [NSString stringWithFormat:@"#%02x%02x%02x%02x", red, green, blue, alpha];
	}
	
	return [NSString stringWithFormat:@"#%02x%02x%02x", red, green, blue];
    
}

- (CGFloat)r_Ext {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	return rgba[0];
}

- (CGFloat)g_Ext {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	return rgba[1];
}

- (CGFloat)b_Ext {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	return rgba[2];
}

- (CGFloat)a_Ext {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	return rgba[3];
}


@end
