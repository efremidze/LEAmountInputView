//
//  LEAmountInputView.h
//  LEAmountInputView
//
//  Created by Lasha Efremidze on 4/29/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LEAmountInputView;
@class LENumberPad;

@protocol LEAmountInputViewDelegate <NSObject>

@optional
/**
 *  Asks the delegate whether the amount should be changed.
 *
 *  If you do not implement this method, the default return value is YES.
 *
 *  @param amountInputView The amount input view object that is asking whether the amount should change.
 *  @param amount          The new amount asked to change to.
 *
 *  @return YES if the amount should be changed or NO if it should not.
 */
- (BOOL)amountInputView:(LEAmountInputView *)amountInputView shouldChangeAmount:(NSNumber *)amount;

/**
 *  Tells the delegate that the amount changed. It does not call this method when you programmatically set the amount.
 *
 *  @param amountInputView The amount input view object that is notifying you of the change.
 *  @param amount          The amount that was changed.
 */
- (void)amountInputView:(LEAmountInputView *)amountInputView didChangeAmount:(NSNumber *)amount;

@end

/**
 *  The `LEAmountInputView` class is an amount input view inspired by Square's design.
 */
@interface LEAmountInputView : UIView

/** The delegate of the view. */
@property (nonatomic, weak) id<LEAmountInputViewDelegate> delegate;

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
