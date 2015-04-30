//
//  UIColor+LEFlatButton.m
//  LEFlatButton
//
//  Created by Lasha Efremidze on 3/28/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "UIColor+LEFlatButton.h"

@implementation UIColor (LEFlatButton)

- (UIColor *)lighterColor;
{
    CGFloat hue = 0.0f, saturation = 0.0f, brightness = 0.0f, alpha = 0.0f;
    if ([self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha])
        return [UIColor colorWithHue:hue saturation:saturation brightness:MIN(brightness * 1.3, 1.0) alpha:alpha];
    return self;
}

- (UIColor *)darkerColor;
{
    CGFloat hue = 0.0f, saturation = 0.0f, brightness = 0.0f, alpha = 0.0f;
    if ([self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha])
        return [UIColor colorWithHue:hue saturation:saturation brightness:brightness * 0.75 alpha:alpha];
    return self;
}

@end
