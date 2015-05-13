//
//  LEAmountInputView.h
//  LEAmountInputView
//
//  Created by Lasha Efremidze on 4/29/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LEAmountInputView;

@protocol LEAmountInputViewDelegate <NSObject>

@optional
- (BOOL)amountInputView:(LEAmountInputView *)amountInputView shouldInputDigit:(NSString *)digit;
- (void)amountInputView:(LEAmountInputView *)amountInputView didInputDigit:(NSString *)digit;
- (BOOL)amountInputViewShouldClear:(LEAmountInputView *)amountInputView;
- (void)amountInputViewDidClear:(LEAmountInputView *)amountInputView;

@end

@interface LEAmountInputView : UIView

@property (nonatomic, weak) id<LEAmountInputViewDelegate> delegate;

@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@property (nonatomic, strong) NSNumber *amount;

// Customize UI

@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, strong) UIColor *textFieldTextColor;
@property (nonatomic, strong) UIFont *textFieldFont;

@property (nonatomic, strong) UIColor *buttonTitleColor;
@property (nonatomic, strong) UIFont *buttonTitleFont;
@property (nonatomic, strong) UIColor *buttonHighlightedColor;

// Initializers

- (instancetype)initWithFrame:(CGRect)frame numberStyle:(NSNumberFormatterStyle)numberStyle;

@end
