//
//  LEAmountInputTextField.m
//  LEAmountInputViewDemo
//
//  Created by Lasha Efremidze on 6/10/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "LEAmountInputTextField.h"
#import "NSNumberFormatter+LEAmountInputView.h"

@interface LEAmountInputTextField () <LENumberPadDataSource, LENumberPadDelegate>

@property (nonatomic, strong) NSNumberFormatter *numberFormatter;

@end

@implementation LEAmountInputTextField

@synthesize delegate;

- (instancetype)initWithFrame:(CGRect)frame numberStyle:(NSNumberFormatterStyle)numberStyle;
{
    self = [self initWithFrame:frame];
    if (self) {
        self.numberStyle = numberStyle;
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
    self.textColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
    self.font = [UIFont systemFontOfSize:40.0f];
    self.textAlignment = NSTextAlignmentRight;
    self.placeholder = [self.numberFormatter currencyString:nil];
    self.inputView = self.numberPad;
}

#pragma mark - Override Properties

- (LENumberPad *)numberPad
{
    if (!_numberPad) {
        _numberPad = [[LENumberPad alloc] initWithFrame:CGRectZero];
        _numberPad.translatesAutoresizingMaskIntoConstraints = NO;
        _numberPad.layer.borderColor = [UIColor colorWithWhite:0.9f alpha:1.0f].CGColor;
        _numberPad.layer.borderWidth = 1.0f;
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
    if (amount.doubleValue) {
        self.text = [self.numberFormatter stringFromNumber:amount];
    } else {
        self.text = nil;
    }
}

- (NSNumber *)amount;
{
    return [self.numberFormatter amountFromString:self.text];
}

- (void)setNumberStyle:(NSNumberFormatterStyle)numberStyle
{
    self.numberFormatter.numberStyle = numberStyle;
    
    self.placeholder = [self.numberFormatter currencyString:nil];
}

- (NSNumberFormatterStyle)numberStyle
{
    return self.numberFormatter.numberStyle;
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
    return [NSString stringWithFormat:@"%d", (int)indexPath.item + 1];
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
    NSNumber *amount = @0;
    
    if (indexPath.item != 9) {
        UIButton *button = [numberPad buttonAtIndexPath:indexPath];
        NSMutableString *string = [NSMutableString stringWithString:self.text];
        if (self.selectedTextRange) {
            NSInteger idx = [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
            [string insertString:button.titleLabel.text atIndex:idx];
        } else {
            [string appendString:button.titleLabel.text];
        }
        amount = [self.numberFormatter amountFromString:string];
    }
    
    if ([amount isEqualToNumber:self.amount] || ![self shouldChangeAmount:amount]) {
        return;
    }
    
    self.amount = amount;
    
    [self didChangeAmount:amount];
}

#pragma mark - Private

- (BOOL)shouldChangeAmount:(NSNumber *)amount
{
    if ([delegate respondsToSelector:@selector(textField:shouldChangeAmount:)]) {
        return [delegate textField:self shouldChangeAmount:amount];
    }
    return YES;
}

- (void)didChangeAmount:(NSNumber *)amount
{
    if ([delegate respondsToSelector:@selector(textField:didChangeAmount:)]) {
        [delegate textField:self didChangeAmount:amount];
    }
}

@end
