//
//  ViewController.m
//  LESaleViewDemo
//
//  Created by Lasha Efremidze on 4/28/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "ViewController.h"
#import "LESaleView.h"

@interface ViewController () <LESaleViewDelegate>

@property (nonatomic, weak) IBOutlet LESaleView *saleView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.saleView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LESaleViewDelegate

- (BOOL)saleView:(LESaleView *)saleView shouldInputDigit:(NSString *)digit
{
    double maxAmount = 999999.99;
    double totalAmount = (saleView.amount.doubleValue * 10) + digit.doubleValue;
    if (totalAmount > maxAmount) {
        saleView.amount = @(maxAmount);
        return NO;
    }
    return YES;
}

@end
