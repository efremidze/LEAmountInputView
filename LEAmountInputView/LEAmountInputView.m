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
        self.numberFormatter.numberStyle = numberStyle;
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
    [self addSubview:self.textField];
    [self addSubview:self.numberPad];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textField.placeholder = [self currencyString:nil];
}

#pragma mark - Override Properties

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:(CGRect){20, 0, self.frame.size.width - 40, self.frame.size.height / 5.0f}];
        _textField.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _textField.backgroundColor = [UIColor clearColor];
        _textField.textColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
        _textField.font = [UIFont systemFontOfSize:40.0f];
        _textField.textAlignment = NSTextAlignmentRight;
    }
    return _textField;
}

- (LENumberPad *)numberPad
{
    if (!_numberPad) {
        _numberPad = [[LENumberPad alloc] initWithFrame:(CGRect){0, self.textField.frame.size.height, self.frame.size.width, self.frame.size.height - self.textField.frame.size.height}];
        _numberPad.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _numberPad.delegate = self;
        _numberPad.layer.borderColor = [UIColor colorWithWhite:0.9f alpha:1.0f].CGColor;
        _numberPad.layer.borderWidth = 1.0f;
    }
    return _numberPad;
}

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

#pragma mark - LENumberPadDelegate

- (void)numberPad:(LENumberPad *)numberPad didSelectButtonAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 9) {
        self.textField.text = nil;
    } else {
        UIButton *button = [numberPad buttonAtIndexPath:indexPath];
        NSString *string = [self.textField.text stringByAppendingString:button.titleLabel.text];
        NSNumber *amount = [self amountFromString:string];
        if ([self shouldInputDigit:amount]) {
            self.textField.text = (amount.doubleValue == 0) ? nil : [self.numberFormatter stringFromNumber:amount];
        }
    }
}

#pragma mark - Private

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

- (BOOL)shouldInputDigit:(NSNumber *)amount
{
    double maxAmount = 999999.99;
    double totalAmount = (self.amount.doubleValue * 10) + amount.doubleValue;
    if (totalAmount > maxAmount) {
        self.amount = @(maxAmount);
        return NO;
    }
    return YES;
}

@end
