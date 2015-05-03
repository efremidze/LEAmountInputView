//
//  LESaleView.h
//  LESaleView
//
//  Created by Lasha Efremidze on 4/29/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LESaleView;

@protocol LESaleViewDelegate <NSObject>

@optional
- (BOOL)saleView:(LESaleView *)saleView shouldInputDigit:(NSString *)digit;
- (void)saleView:(LESaleView *)saleView didInputDigit:(NSString *)digit;
- (BOOL)saleViewShouldClear:(LESaleView *)saleView;
- (void)saleViewDidClear:(LESaleView *)saleView;

@end

@interface LESaleView : UIView

@property (nonatomic, weak) id<LESaleViewDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIView *headerView;

@property (nonatomic, weak) IBOutlet UITextField *textField;

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *buttons;

@property (nonatomic, strong) UIColor *gridColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) NSLocale *locale;

@property (nonatomic, strong) NSNumber *amount;

@end
