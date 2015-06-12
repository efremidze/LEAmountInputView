//
//  LEAmountInputView.h
//  LEAmountInputView
//
//  Created by Lasha Efremidze on 4/29/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LEAmountInputTextField.h"

/**
 *  The `LEAmountInputView` class is an amount input view inspired by Square's design.
 */
@interface LEAmountInputView : UIView

/**
 *  The textField of the `LEAmountInputView`.
 */
@property (nonatomic, strong) LEAmountInputTextField *textField;

/**
 *  Initializes a new `LEAmountInputView` with the specified frame rectangle and number style.
 *
 *  @param frame       The frame rectangle for the view, measured in points.
 *  @param numberStyle The number style of the view. Sets the numberStyle of the textField's `numberFormatter`.
 *
 *  @return An initialized `LEAmountInputView` or nil if couldn't be created.
 */
- (instancetype)initWithFrame:(CGRect)frame numberStyle:(NSNumberFormatterStyle)numberStyle;

@end
