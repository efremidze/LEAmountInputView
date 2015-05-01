//
//  LESaleView.m
//  LESaleView
//
//  Created by Lasha Efremidze on 4/29/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "LESaleView.h"
#import "LESaleCalculator.h"

#import "XXNibBridge.h"

#import "UIImage+LESaleView.h"
#import "UITextField+LESaleView.h"

@interface LESaleView () <XXNibBridge>

@property (nonatomic, weak) IBOutlet UIView *gridView;

@property (nonatomic, strong) LESaleCalculator *saleCalculator;

@end

@implementation LESaleView

- (instancetype)init
{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.gridColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    self.textColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
    self.font = [UIFont systemFontOfSize:40.0f];
    
    self.saleCalculator = [LESaleCalculator new];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.borderColor = self.gridColor.CGColor;
    self.layer.borderWidth = 1.0f;
    
    self.gridView.backgroundColor = self.gridColor;
    
    // textfields
    self.textField.enabled = NO;
    self.textField.textColor = self.textColor;
    self.textField.font = self.font;
    self.textField.placeholder = [self.saleCalculator currencyStringFromString:@""];
    
    // buttons
    for (UIButton *button in self.buttons) {
        button.titleLabel.font = self.font;
        
        UIColor *titleColor = [self titleColorForButton:button];
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        [button setTitleColor:titleColor forState:UIControlStateHighlighted];
        [button setTitleColor:titleColor forState:UIControlStateSelected];
        
        UIImage *backgroundImage = [UIImage imageFromColor:self.backgroundColor];
        [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        backgroundImage = [UIImage imageFromColor:self.gridColor];
        [button setBackgroundImage:backgroundImage forState:UIControlStateHighlighted];
        [button setBackgroundImage:backgroundImage forState:UIControlStateSelected];
    }
}

#pragma mark - Override Properties

- (void)setLocale:(NSLocale *)locale
{
    self.saleCalculator.numberFormatter.locale = locale;
}

- (NSLocale *)locale
{
    return self.saleCalculator.numberFormatter.locale;
}

#pragma mark - IBActions

- (IBAction)didTouchOnClearButton:(UIButton *)button
{
    self.textField.text = nil;
}

- (IBAction)didTouchOnDigitButton:(UIButton *)button
{
    NSString *string = [self.textField.text stringByAppendingString:button.titleLabel.text];
    self.textField.text = [self.saleCalculator currencyStringFromString:string];
}

#pragma mark - Helpers

- (UIColor *)titleColorForButton:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:@"C"]) {
        return [UIColor orangeColor];
    }
    return [self textColor];
}

- (NSNumber *)amount;
{
    return [self.saleCalculator amountFromString:self.textField.text];
}

@end
