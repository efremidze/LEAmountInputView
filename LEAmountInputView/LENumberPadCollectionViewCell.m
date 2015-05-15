//
//  LENumberPadCollectionViewCell.m
//  LEAmountInputView
//
//  Created by Lasha Efremidze on 5/13/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "LENumberPadCollectionViewCell.h"

@implementation LENumberPadCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.layer.shouldRasterize = YES;
    
    [self.contentView addSubview:self.button];
    
    NSDictionary *views = @{@"button": self.button};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[button]|" options:0 metrics:0 views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button]|" options:0 metrics:0 views:views]];
}

#pragma mark - Override Properties

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        _button.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _button;
}

@end
