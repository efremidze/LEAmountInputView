//
//  LEAmountInputView.m
//  LEAmountInputView
//
//  Created by Lasha Efremidze on 4/29/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "LEAmountInputView.h"

@interface LEAmountInputView ()

@end

@implementation LEAmountInputView

- (instancetype)initWithFrame:(CGRect)frame numberStyle:(NSNumberFormatterStyle)numberStyle;
{
    self = [self initWithFrame:frame];
    if (self) {
        self.textField.numberStyle = numberStyle;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize;
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.borderColor = [UIColor colorWithWhite:0.9f alpha:1.0f].CGColor;
    self.layer.borderWidth = 1.0f;
    
    [self addSubview:self.textField];
    [self addSubview:self.numberPad];
    
    NSDictionary *views = @{@"textField": self.textField, @"numberPad": self.numberPad};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[textField]-20-|" options:0 metrics:0 views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[numberPad]|" options:0 metrics:0 views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textField][numberPad]|" options:0 metrics:0 views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.numberPad attribute:NSLayoutAttributeHeight multiplier:1.0f / self.numberPad.numberOfRows constant:0]];
}

#pragma mark - Override Properties

- (LEAmountInputTextField *)textField
{
    if (!_textField) {
        _textField = [[LEAmountInputTextField alloc] initWithFrame:CGRectZero];
        _textField.translatesAutoresizingMaskIntoConstraints = NO;
        _textField.backgroundColor = [UIColor clearColor];
        _textField.enabled = NO;
    }
    return _textField;
}

- (LENumberPad *)numberPad
{
    return self.textField.numberPad;
}

@end
