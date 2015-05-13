//
//  LEAmountInputView.h
//  LEAmountInputView
//
//  Created by Lasha Efremidze on 4/29/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LEAmountInputView;

@protocol LEAmountInputViewDataSource <NSObject>

@optional
- (NSInteger)numberOfColumnsInAmountInputView:(LEAmountInputView *)amountInputView;
- (NSInteger)numberOfRowsInAmountInputView:(LEAmountInputView *)amountInputView;
- (NSString *)amountInputView:(LEAmountInputView *)amountInputView buttonTitleForButtonAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)amountInputView:(LEAmountInputView *)amountInputView buttonTitleColorForButtonAtIndexPath:(NSIndexPath *)indexPath;
- (UIFont *)amountInputView:(LEAmountInputView *)amountInputView buttonTitleFontForButtonAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)amountInputView:(LEAmountInputView *)amountInputView buttonBackgroundColorForButtonAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)amountInputView:(LEAmountInputView *)amountInputView buttonBackgroundHighlightedColorForButtonAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol LEAmountInputViewDelegate <NSObject>

@optional
- (void)amountInputView:(LEAmountInputView *)amountInputView didSelectButtonAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface LEAmountInputView : UIView

@property (nonatomic, weak) id<LEAmountInputViewDataSource> dataSource;
@property (nonatomic, weak) id<LEAmountInputViewDelegate> delegate;

- (UIButton *)buttonAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathForButton:(UIButton *)button;

@end
