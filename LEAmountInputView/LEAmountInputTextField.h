//
//  LEAmountInputTextField.h
//  LEAmountInputViewDemo
//
//  Created by Lasha Efremidze on 6/10/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LENumberPad.h"

@class LEAmountInputTextField;

@protocol LEAmountInputTextFieldDelegate <UITextFieldDelegate>

@optional
- (BOOL)textField:(LEAmountInputTextField *)textField shouldChangeAmount:(NSNumber *)amount;
- (void)textField:(LEAmountInputTextField *)textField didChangeAmount:(NSNumber *)amount;

@end

@interface LEAmountInputTextField : UITextField

@property (nonatomic, weak) id<LEAmountInputTextFieldDelegate> delegate;

@property (nonatomic, strong) LENumberPad *numberPad;

@property (nonatomic) NSNumberFormatterStyle numberStyle;

@property (nonatomic, strong) NSNumber *amount;

- (instancetype)initWithFrame:(CGRect)frame numberStyle:(NSNumberFormatterStyle)numberStyle;

@end
