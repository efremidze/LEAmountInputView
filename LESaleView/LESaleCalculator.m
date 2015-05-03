//
//  LESaleCalculator.m
//  LESaleView
//
//  Created by Lasha Efremidze on 4/30/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "LESaleCalculator.h"

@implementation LESaleCalculator

- (NSNumberFormatter *)numberFormatter
{
    if (!_numberFormatter) {
        _numberFormatter = [NSNumberFormatter new];
        _numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    }
    return _numberFormatter;
}

#pragma mark -

- (NSString *)currencyString:(NSString *)string;
{
    NSNumber *amount = [self amountFromString:string];
    return [self.numberFormatter stringFromNumber:amount];
}

- (NSNumber *)amountFromString:(NSString *)string;
{
    if (string.length) {
        NSDecimalNumber *digits = [NSDecimalNumber decimalNumberWithString:[self sanitizedString:string]];
        NSDecimalNumber *decimalPlace = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble:pow(10.0, self.numberFormatter.minimumFractionDigits)];
        return [digits decimalNumberByDividingBy:decimalPlace];
    }
    return @0;
}

#pragma mark - Private

- (NSString *)sanitizedString:(NSString *)string;
{
    return [[string componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:[NSString string]];
}

@end
