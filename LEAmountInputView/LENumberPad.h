//
//  LENumberPad.h
//  LEAmountInputView
//
//  Created by Lasha Efremidze on 5/13/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LENumberPad;

@protocol LENumberPadDataSource <NSObject>

@optional
- (NSInteger)numberOfColumnsInNumberPad:(LENumberPad *)numberPad;
- (NSInteger)numberOfRowsInNumberPad:(LENumberPad *)numberPad;
- (NSString *)numberPad:(LENumberPad *)numberPad buttonTitleForButtonAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)numberPad:(LENumberPad *)numberPad buttonTitleColorForButtonAtIndexPath:(NSIndexPath *)indexPath;
- (UIFont *)numberPad:(LENumberPad *)numberPad buttonTitleFontForButtonAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)numberPad:(LENumberPad *)numberPad buttonBackgroundColorForButtonAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)numberPad:(LENumberPad *)numberPad buttonBackgroundHighlightedColorForButtonAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol LENumberPadDelegate <NSObject>

@optional
- (void)numberPad:(LENumberPad *)numberPad didSelectButtonAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface LENumberPad : UIView

@property (nonatomic, weak) id<LENumberPadDataSource> dataSource;
@property (nonatomic, weak) id<LENumberPadDelegate> delegate;

- (UIButton *)buttonAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathForButton:(UIButton *)button;

@end
