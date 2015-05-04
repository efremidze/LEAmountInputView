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

@property (nonatomic, weak) IBOutlet UIView *gridView;
@property (nonatomic, weak) IBOutlet UIView *headerView;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *buttons;

@property (nonatomic, strong) UIColor *gridColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@property (nonatomic, strong) NSNumber *amount;

- (instancetype)initWithFrame:(CGRect)frame numberStyle:(NSNumberFormatterStyle)numberStyle;

- (UIColor *)titleColorForButton:(UIButton *)button;

@end
