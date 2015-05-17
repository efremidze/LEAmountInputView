//
//  LEAmountInputView.h
//  LEAmountInputView
//
//  Created by Lasha Efremidze on 4/29/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LENumberPad.h"

/**
 *  The `LEAmountInputView` class is an amount input view inspired by Square's design.
 */
@interface LEAmountInputView : UIView <LENumberPadDataSource, LENumberPadDelegate>

/** The text field of the view. */
@property (nonatomic, strong) UITextField *textField;

/**
 *  The number pad of the view.
 *
 *  Supports customization using the `dataSource` and `delegate` protocols.
 *
 *  @see LENumberPad class.
 */
@property (nonatomic, strong) LENumberPad *numberPad;

/**
 *  The number formatter of the amount.
 *
 *  This formats the amount displayed in the `textField`.
 */
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;

/** The amount displayed in the view. */
@property (nonatomic, strong) NSNumber *amount;

/**
 *  Initializes a new amount input view with the specified frame rectangle and number style.
 *
 *  @param frame       The frame rectangle for the view, measured in points.
 *  @param numberStyle The number style of the view. Sets the numberStyle of the `numberFormatter`.
 *
 *  @return An initialized amount input view or nil if couldn't be created.
 */
- (instancetype)initWithFrame:(CGRect)frame numberStyle:(NSNumberFormatterStyle)numberStyle;

@end
