//
//  LEAmountInputView.m
//  LEAmountInputView
//
//  Created by Lasha Efremidze on 4/29/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "LEAmountInputView.h"
#import "UIImage+LEAmountInputView.h"

#import "XXNibBridge.h"

@interface LEAmountInputView () <XXNibBridge>

@end

@implementation LEAmountInputView

- (instancetype)initWithFrame:(CGRect)frame numberStyle:(NSNumberFormatterStyle)numberStyle;
{
    if (self = [self initWithFrame:frame]) {
        self.numberFormatter.numberStyle = numberStyle;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        self.frame = frame;
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.gridColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    self.textColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
    self.font = [UIFont systemFontOfSize:40.0f];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layer.borderColor = self.gridColor.CGColor;
    self.layer.borderWidth = 1.0f;
    
    // gridview
    self.gridView.backgroundColor = self.gridColor;
    
    // textfield
    self.textField.textColor = self.textColor;
    self.textField.font = self.font;
    self.textField.placeholder = [self currencyString:nil];
    
    // buttons
    for (UIButton *button in self.buttons) {
        button.titleLabel.font = self.font;
        
        UIColor *titleColor = [self titleColorForButton:button];
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        [button setTitleColor:titleColor forState:UIControlStateHighlighted];
        [button setTitleColor:titleColor forState:UIControlStateSelected];
        
        UIImage *backgroundImage = [UIImage imageFromColor:self.backgroundColor];
        [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        backgroundImage = [UIImage imageFromColor:self.gridColor];
        [button setBackgroundImage:backgroundImage forState:UIControlStateHighlighted];
        [button setBackgroundImage:backgroundImage forState:UIControlStateSelected];
    }
}

#pragma mark - Override Properties

- (NSNumberFormatter *)numberFormatter
{
    if (!_numberFormatter) {
        _numberFormatter = [NSNumberFormatter new];
    }
    return _numberFormatter;
}

- (void)setAmount:(NSNumber *)amount
{
    self.textField.text = [self.numberFormatter stringFromNumber:amount];
}

- (NSNumber *)amount;
{
    return [self amountFromString:self.textField.text];
}

#pragma mark - IBActions

- (IBAction)didTouchOnClearButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(amountInputViewShouldClear:)]) {
        if (![self.delegate amountInputViewShouldClear:self]) {
            return;
        }
    }
    
    self.textField.text = nil;
    
    if ([self.delegate respondsToSelector:@selector(amountInputViewDidClear:)]) {
        [self.delegate amountInputViewDidClear:self];
    }
}

- (IBAction)didTouchOnDigitButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(amountInputView:shouldInputDigit:)]) {
        if (![self.delegate amountInputView:self shouldInputDigit:button.titleLabel.text]) {
            return;
        }
    }
    
    NSString *string = [self.textField.text stringByAppendingString:button.titleLabel.text];
    NSNumber *amount = [self amountFromString:string];
    self.textField.text = (amount.doubleValue == 0) ? nil : [self.numberFormatter stringFromNumber:amount];
    
    if ([self.delegate respondsToSelector:@selector(amountInputView:didInputDigit:)]) {
        [self.delegate amountInputView:self didInputDigit:button.titleLabel.text];
    }
}

#pragma mark - Helpers

- (UIColor *)titleColorForButton:(UIButton *)button;
{
    if ([button.titleLabel.text isEqualToString:@"C"]) {
        return [UIColor orangeColor];
    }
    return [self textColor];
}

- (NSString *)currencyString:(NSString *)string;
{
    NSNumber *amount = [self amountFromString:string];
    return [self.numberFormatter stringFromNumber:amount];
}

- (NSNumber *)amountFromString:(NSString *)string;
{
    string = [self sanitizedString:string];
    if (string.doubleValue == 0) {
        return @0;
    }
    NSDecimalNumber *digits = [NSDecimalNumber decimalNumberWithString:string];
    NSDecimalNumber *decimalPlace = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble:pow(10.0, self.numberFormatter.minimumFractionDigits)];
    return [digits decimalNumberByDividingBy:decimalPlace];
}

- (NSString *)sanitizedString:(NSString *)string;
{
    return [[string componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:[NSString string]];
}

@end
