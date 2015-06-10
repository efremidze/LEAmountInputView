//
//  NSNumberFormatter+LEAmountInputView.h
//  LEAmountInputViewDemo
//
//  Created by Lasha Efremidze on 6/10/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumberFormatter (LEAmountInputView)

- (NSString *)currencyString:(NSString *)string;

- (NSNumber *)amountFromString:(NSString *)string;

@end
