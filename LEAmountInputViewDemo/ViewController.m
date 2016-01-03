//
//  ViewController.m
//  LEAmountInputViewDemo
//
//  Created by Lasha Efremidze on 5/3/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "ViewController.h"
#import "LEAmountInputView.h"

@interface ViewController () <LEAmountInputTextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
}

#pragma mark - LEAmountInputView

- (void)setup
{
    LEAmountInputView *amountInputView = [[LEAmountInputView alloc] initWithFrame:CGRectZero numberStyle:NSNumberFormatterCurrencyStyle];
    amountInputView.translatesAutoresizingMaskIntoConstraints = NO;
    amountInputView.textField.delegate = self;
    [self.view addSubview:amountInputView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(amountInputView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[amountInputView]-10-|" options:0 metrics:0 views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[amountInputView]-10-|" options:0 metrics:0 views:views]];
}

#pragma mark - LEAmountInputTextFieldDelegate

- (BOOL)textField:(LEAmountInputTextField *)textField shouldChangeAmount:(NSNumber *)amount
{
    NSLog(@"%s %@", __PRETTY_FUNCTION__, amount);
    
    double maxAmount = 999999.99;
    double totalAmount = amount.doubleValue;
    if (totalAmount > maxAmount) {
        textField.amount = @(maxAmount);
        return NO;
    }
    return YES;
}

- (void)textField:(LEAmountInputTextField *)textField didChangeAmount:(NSNumber *)amount
{
    NSLog(@"%s %@", __PRETTY_FUNCTION__, amount);
}

@end
