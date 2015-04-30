//
//  LEFlatButton.m
//  LEFlatButton
//
//  Created by Lasha Efremidze on 3/28/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "LEFlatButton.h"

#import "UIImage+LEFlatButton.h"
#import "UIColor+LEFlatButton.h"

@implementation LEFlatButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize;
{
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - Override Accessors

- (UIColor *)foregroundHighlightedColor
{
    return _foregroundHighlightedColor ?: [self.foregroundColor darkerColor];
}

- (UIColor *)backgroundHighlightedColor
{
    return _backgroundHighlightedColor ?: [self.backgroundColor darkerColor];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderHighlightedColor
{
    return _borderHighlightedColor ?: [self.borderColor darkerColor];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.layer.borderColor = (selected ? self.borderHighlightedColor.CGColor : self.borderColor.CGColor);
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    self.layer.borderColor = (highlighted ? self.borderHighlightedColor.CGColor : self.borderColor.CGColor);
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    self.backgroundColor = (enabled ? self.backgroundColor : [self.backgroundHighlightedColor colorWithAlphaComponent:0.5f]);
    [self setNeedsDisplay];
}

#pragma mark - Appearance

- (void)setFlatTitle:(NSString *)title
{
    [self setTitle:title];
    [self loadTitleColor];
    [self loadBackgroundImage];
}

- (void)setFlatImage:(UIImage *)image
{
    [self setImage:image];
    [self loadBackgroundImage];
}

#pragma mark - Helpers

- (void)setTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
    [self setTitle:title forState:UIControlStateSelected];
}

- (void)loadTitleColor
{
    UIColor *color = self.foregroundColor;
    [self setTitleColor:color forState:UIControlStateNormal];
    color = self.foregroundHighlightedColor;
    [self setTitleColor:color forState:UIControlStateHighlighted];
    [self setTitleColor:color forState:UIControlStateSelected];
}

- (void)setImage:(UIImage *)image
{
    image = [image tintedWithColor:self.foregroundColor];
    [self setImage:image forState:UIControlStateNormal];
    image = [image tintedWithColor:self.foregroundHighlightedColor];
    [self setImage:image forState:UIControlStateHighlighted];
    [self setImage:image forState:UIControlStateSelected];
}

- (void)loadBackgroundImage
{
    UIImage *image = [UIImage imageFromColor:self.backgroundColor];
    [self setBackgroundImage:image forState:UIControlStateNormal];
    image = [UIImage imageFromColor:self.backgroundHighlightedColor];
    [self setBackgroundImage:image forState:UIControlStateHighlighted];
    [self setBackgroundImage:image forState:UIControlStateSelected];
}

@end
