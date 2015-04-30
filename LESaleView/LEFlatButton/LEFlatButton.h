//
//  LEFlatButton.h
//  LEFlatButton
//
//  Created by Lasha Efremidze on 3/28/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LEFlatButton : UIButton

@property (nonatomic, strong) UIColor *foregroundColor;
@property (nonatomic, strong) UIColor *foregroundHighlightedColor;

@property (nonatomic, strong) UIColor *backgroundHighlightedColor;

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *borderHighlightedColor;

- (void)setFlatTitle:(NSString *)title;
- (void)setFlatImage:(UIImage *)image;

@end
