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
    self = [super initWithFrame:frame];
    if (self) {
        self.numberFormatter.numberStyle = numberStyle;
        [self initialize];
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
    self.layer.borderColor = [UIColor colorWithWhite:0.9f alpha:1.0f].CGColor;
    self.layer.borderWidth = 1.0f;
    
    self.numberPad.layer.borderColor = [UIColor colorWithWhite:0.9f alpha:1.0f].CGColor;
    self.numberPad.layer.borderWidth = 1.0f;
    
    [self addSubview:self.textField];
    [self addSubview:self.numberPad];
    
    NSDictionary *views = @{@"textField": self.textField, @"numberPad": self.numberPad};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[textField]-20-|" options:0 metrics:0 views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[numberPad]|" options:0 metrics:0 views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textField][numberPad]|" options:0 metrics:0 views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.numberPad attribute:NSLayoutAttributeHeight multiplier:1.0f / self.numberPad.numberOfRows constant:0]];
}

#pragma mark - Override Properties

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.translatesAutoresizingMaskIntoConstraints = NO;
        _textField.backgroundColor = [UIColor clearColor];
        _textField.textColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
        _textField.font = [UIFont systemFontOfSize:40.0f];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.placeholder = [self currencyString:nil];
        _textField.enabled = NO;
    }
    return _textField;
}

- (LENumberPad *)numberPad
{
    if (!_numberPad) {
        _numberPad = [[LENumberPad alloc] initWithFrame:CGRectZero];
        _numberPad.translatesAutoresizingMaskIntoConstraints = NO;
        _numberPad.dataSource = self;
        _numberPad.delegate = self;
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

#pragma mark - LENumberPadDataSource

- (NSInteger)numberOfColumnsInNumberPad:(LENumberPad *)numberPad;
{
    return 3;
}

- (NSInteger)numberOfRowsInNumberPad:(LENumberPad *)numberPad;
{
    return 4;
}

- (NSString *)numberPad:(LENumberPad *)numberPad buttonTitleForButtonAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.item == 9) {
        return @"C";
    } else if (indexPath.item == 10) {
        return @"0";
    } else if (indexPath.item == 11) {
        return @"00";
    }
    return [NSString stringWithFormat:@"%ld", indexPath.item + 1];
}

- (UIColor *)numberPad:(LENumberPad *)numberPad buttonTitleColorForButtonAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.item == 9) {
        return [UIColor orangeColor];
    }
    return [UIColor colorWithWhite:0.3f alpha:1.0f];
}

- (UIFont *)numberPad:(LENumberPad *)numberPad buttonTitleFontForButtonAtIndexPath:(NSIndexPath *)indexPath;
{
    return [UIFont systemFontOfSize:40.0f];
}

- (UIColor *)numberPad:(LENumberPad *)numberPad buttonBackgroundColorForButtonAtIndexPath:(NSIndexPath *)indexPath;
{
    return [UIColor whiteColor];
}

- (UIColor *)numberPad:(LENumberPad *)numberPad buttonBackgroundHighlightedColorForButtonAtIndexPath:(NSIndexPath *)indexPath;
{
    return [UIColor colorWithWhite:0.9f alpha:1.0f];
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
