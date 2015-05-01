//
//  LESaleCalculator.h
//  LESaleView
//
//  Created by Lasha Efremidze on 4/30/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LESaleCalculator : NSObject

@property (nonatomic, strong) NSNumberFormatter *numberFormatter;

- (NSString *)currencyStringFromString:(NSString *)string;

- (int)integerDigitsLengthFromString:(NSString *)string;

- (NSNumber *)amountFromString:(NSString *)string;

@end
