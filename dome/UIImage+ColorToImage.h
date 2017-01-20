//
//  UIImage+ColorToImage.h
//  MIT_Integrated
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 apple. All rights reserved.
/***************************************
 ClassName：  UIImage (ColorToImage)
 Created_Date： 20150916
 Created_People： jsq
 Function_description： 根据颜色绘制图片
 ***************************************/

#import <UIKit/UIKit.h>

@interface UIImage (ColorToImage)
+(UIImage*) createImageWithColor:(UIColor*) color frame:(CGRect)frame;
+(UIImage *)circleImageWithImage:(UIImage *)oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
@end
