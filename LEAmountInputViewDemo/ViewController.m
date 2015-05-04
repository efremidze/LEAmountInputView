//
//  ViewController.m
//  LEAmountInputViewDemo
//
//  Created by Lasha Efremidze on 5/3/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "ViewController.h"
#import "LEAmountInputView.h"

@interface ViewController () <LEAmountInputViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LEAmountInputView

- (void)setup
{
    LEAmountInputView *amountInputView = [[LEAmountInputView alloc] initWithFrame:CGRectZero numberStyle:NSNumberFormatterCurrencyStyle];
    amountInputView.delegate = self;
    amountInputView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:amountInputView];
    
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:amountInputView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.0
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:amountInputView
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1.0
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:amountInputView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.0
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:amountInputView
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1
                                                              constant:0],
                                ]];
}

#pragma mark - LEAmountInputViewDelegate

- (BOOL)amountInputView:(LEAmountInputView *)amountInputView shouldInputDigit:(NSString *)digit
{
    double maxAmount = 999999.99;
    double totalAmount = (amountInputView.amount.doubleValue * 10) + digit.doubleValue;
    if (totalAmount > maxAmount) {
        amountInputView.amount = @(maxAmount);
        return NO;
    }
    return YES;
}

@end
