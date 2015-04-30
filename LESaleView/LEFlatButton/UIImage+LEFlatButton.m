//
//  UIImage+LEFlatButton.m
//  LEFlatButton
//
//  Created by Lasha Efremidze on 3/28/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "UIImage+LEFlatButton.h"

@implementation UIImage (LEFlatButton)

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

#pragma mark

- (UIImage *)tintedWithColor:(UIColor *)color;
{
    CGRect rect = (CGRect){0.0f, 0.0f, self.size.width, self.size.height};
    return [self tintedWithColor:color inRect:rect];
}

- (UIImage *)tintedWithColor:(UIColor *)color inRect:(CGRect)rect;
{
    if (!color) return self;
    
    CGRect originalRect = (CGRect){0.0f, 0.0f, self.size.width, self.size.height};
    
    UIGraphicsBeginImageContextWithOptions(originalRect.size, NO, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(ctx, 0.0f, originalRect.size.height);
    CGContextScaleCTM(ctx, 1.0f, -1.0f);
    
    // draw original image
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    CGContextDrawImage(ctx, originalRect, self.CGImage);
    
    // draw tint
    CGContextSetBlendMode(ctx, kCGBlendModeSourceIn);
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextFillRect(ctx, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
