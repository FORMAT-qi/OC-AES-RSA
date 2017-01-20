//
//  UIColor+Additional.h
//  bdcreditAppIOS
//
//  Created by xwzhou on 16/3/18.
//  Copyright © 2016年 kaiyuandao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

@interface UIColor (Additional)

/**
 Returns a color from a HTML/CSS style color specification expressed as an integer.
 @param hexColor An integer representing a color. You can use hex format to express web colors, e.g. 0xAABBCC.
 @return A UIColor represented by the color specification or nil if it was invalid.  The alpha value is set to 100%.
 */
+ (UIColor*)colorWithHex:(NSInteger)hexColor;

+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
