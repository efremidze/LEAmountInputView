//
//  NSNumberFormatter+LEAmountInputView.m
//  LEAmountInputViewDemo
//
//  Created by Lasha Efremidze on 6/10/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "NSNumberFormatter+LEAmountInputView.h"

@implementation NSNumberFormatter (LEAmountInputView)

- (NSString *)currencyString:(NSString *)string;
{
    NSNumber *amount = [self amountFromString:string];
    return [self stringFromNumber:amount];
}

- (NSNumber *)amountFromString:(NSString *)string;
{
    string = [self sanitizedString:string];
    if (string.doubleValue == 0) {
        return @0;
    }
    NSDecimalNumber *digits = [NSDecimalNumber decimalNumberWithString:string];
    NSDecimalNumber *decimalPlace = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble:pow(10.0, self.minimumFractionDigits)];
    return [digits decimalNumberByDividingBy:decimalPlace];
}

#pragma mark - Private

- (NSString *)sanitizedString:(NSString *)string;
{
    return [[string componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:[NSString string]];
}

@end
