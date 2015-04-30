//
//  UIImage+LEFlatButton.h
//  LEFlatButton
//
//  Created by Lasha Efremidze on 3/28/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LEFlatButton)

+ (UIImage *)imageFromColor:(UIColor *)color;

- (UIImage *)tintedWithColor:(UIColor *)color;
- (UIImage *)tintedWithColor:(UIColor *)color inRect:(CGRect)rect;

@end
