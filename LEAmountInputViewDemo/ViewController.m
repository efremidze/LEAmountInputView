//
//  ViewController.m
//  LEAmountInputViewDemo
//
//  Created by Lasha Efremidze on 5/3/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "ViewController.h"
#import "LEAmountInputView.h"

@interface ViewController () <LEAmountInputViewDataSource, LEAmountInputViewDelegate>

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
    LEAmountInputView *amountInputView = [[LEAmountInputView alloc] initWithFrame:self.view.bounds];
    amountInputView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    amountInputView.dataSource = self;
    amountInputView.delegate = self;
    [self.view addSubview:amountInputView];
}

@end
