//
//  UIImage+LEAmountInputView.m
//  LEAmountInputView
//
//  Created by Lasha Efremidze on 4/30/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "UIImage+LEAmountInputView.h"

@implementation UIImage (LEAmountInputView)

+ (UIImage *)imageFromColor:(UIColor *)color;
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
