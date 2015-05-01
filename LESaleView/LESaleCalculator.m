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

- (NSString *)currencyStringFromString:(NSString *)string;
{
    NSNumber *number = [self amountFromString:string];
    return [self.numberFormatter stringFromNumber:number];
}

- (int)integerDigitsLengthFromString:(NSString *)string;
{
    double digits = [self digitsFromString:string];
    return MAX(0, (int)log10(digits));
}

- (NSNumber *)amountFromString:(NSString *)string;
{
    double digits = [self digitsFromString:string];
    double decimalPlace = pow(10.0, self.numberFormatter.minimumFractionDigits);
    return @(digits / decimalPlace);
}

#pragma mark - Private

- (double)digitsFromString:(NSString *)string;
{
    return [[self sanitizedString:string] doubleValue];
}

- (NSString *)sanitizedString:(NSString *)string;
{
    return [[string componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:[NSString string]];
}

@end
