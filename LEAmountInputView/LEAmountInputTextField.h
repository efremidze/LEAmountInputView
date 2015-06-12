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

/**
 *  The LEAmountInputTextFieldDelegate protocol defines the amount messages sent to a text field delegate. All of the methods of this protocol are optional.
 *
 *  Inherits from UITextFieldDelegate.
 */
@protocol LEAmountInputTextFieldDelegate <UITextFieldDelegate>

@optional

/**
 *  Asks the delegate whether the amount should be changed.
 *
 *  If you do not implement this method, the default return value is YES.
 *
 *  @param textField The text field object that is asking whether the amount should change.
 *  @param amount    The new amount.
 *
 *  @return YES if the amount should be changed or NO if it should not.
 */
- (BOOL)textField:(LEAmountInputTextField *)textField shouldChangeAmount:(NSNumber *)amount;

/**
 *  Tells the delegate that the amount changed. It does not call this method when you programmatically set the amount.
 *
 *  @param textField The text field object that is notifying you of the change.
 *  @param amount    The amount that was changed.
 */
- (void)textField:(LEAmountInputTextField *)textField didChangeAmount:(NSNumber *)amount;

@end

/**
 *  The `LEAmountInputTextField` class is a `UITextField` subclass with a `LENumberPad` inputView.
 */
@interface LEAmountInputTextField : UITextField

/**
 *  The receiver’s delegate.
 *
 *  You can you the delegate to respond to text field changes, like the amount.
 */
@property (nonatomic, weak) id<LEAmountInputTextFieldDelegate> delegate;

/**
 *  The number pad used in the receiver's inputView.
 *
 *  Supports customization using the `dataSource` and `delegate` protocols.
 *
 *  @see LENumberPad class.
 */
@property (nonatomic, strong) LENumberPad *numberPad;

/**
 *  The number style of the `LEAmountInputTextField` text.
 */
@property (nonatomic) NSNumberFormatterStyle numberStyle;

/**
 *  The amount value of the `LEAmountInputTextField`.
 */
@property (nonatomic, strong) NSNumber *amount;

/**
 *  Initializes a new `LEAmountInputTextField` with the specified frame rectangle and number style.
 *
 *  @param frame       The frame rectangle for the view, measured in points.
 *  @param numberStyle The number style of the view. Sets the numberStyle of the `numberFormatter`.
 *
 *  @return An initialized `LEAmountInputTextField` or nil if couldn't be created.
 */
- (instancetype)initWithFrame:(CGRect)frame numberStyle:(NSNumberFormatterStyle)numberStyle;

@end
