//
//  LESaleView.m
//  LESaleView
//
//  Created by Lasha Efremidze on 4/29/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "LESaleView.h"

#import "XXNibBridge.h"

#import "UIImage+LESaleView.h"
#import "UITextField+LESaleView.h"

@interface LESaleView () <XXNibBridge>

@end

@implementation LESaleView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [self gridColor];

    self.layer.borderColor = [self gridColor].CGColor;
    self.layer.borderWidth = 1.0f;
    
    self.textField.textColor = [self textColor];
    self.textField.font = [self font];
    self.textField.placeholder = [[self numberFormatter] stringFromNumber:[self amountFromString:nil]];
    self.textField.enabled = NO;
    
    for (UIButton *button in self.buttons) {
        button.titleLabel.font = [self font];
        
        [button setTitleColor:[self titleColorForButton:button] forState:UIControlStateNormal];
        [button setTitleColor:[self titleColorForButton:button] forState:UIControlStateHighlighted];
        [button setTitleColor:[self titleColorForButton:button] forState:UIControlStateSelected];
        
        [button setBackgroundImage:[UIImage imageFromColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageFromColor:[self gridColor]] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageFromColor:[self gridColor]] forState:UIControlStateSelected];
    }
}

#pragma mark -

- (UIColor *)gridColor
{
    return [UIColor colorWithWhite:0.9f alpha:1.0f];
}

- (UIColor *)textColor
{
    return [UIColor colorWithWhite:0.3f alpha:1.0f];
}

- (UIFont *)font
{
    return [UIFont systemFontOfSize:40.0f];
}

- (UIColor *)titleColorForButton:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:@"C"]) {
        return [UIColor orangeColor];
    }
    return [self textColor];
}

#pragma mark -

- (IBAction)didTouchOnClearButton:(UIButton *)button
{
    if ([self.textField.delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        if (![self.textField.delegate textFieldShouldClear:self.textField]) {
            return;
        }
    }
    self.textField.text = nil;
}

- (IBAction)didTouchOnNumberButton:(UIButton *)button
{
    if ([self.textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        NSRange range = [self.textField selectedRange];
        if (![self.textField.delegate textField:self.textField shouldChangeCharactersInRange:range replacementString:button.titleLabel.text]) {
            return;
        }
    }
    NSString *string = [self.textField.text stringByAppendingString:button.titleLabel.text];
    self.textField.text = [[self numberFormatter] stringFromNumber:[self amountFromString:string]];
}

#pragma mark -

- (NSNumberFormatter *)numberFormatter
{
    static NSNumberFormatter *_numberFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _numberFormatter = [NSNumberFormatter new];
        _numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        _numberFormatter.locale = self.locale;
    });
    return _numberFormatter;
}

- (NSLocale *)locale
{
    if (!_locale) {
        _locale = [NSLocale currentLocale];
    }
    return _locale;
}

- (NSNumber *)amountFromString:(NSString *)string
{
    NSString *digitString = [[string componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:[NSString string]];
    return @(digitString.doubleValue / pow(10.0, [self numberFormatter].minimumFractionDigits));
}

@end
