//
//  LESaleView.m
//  LESaleView
//
//  Created by Lasha Efremidze on 4/29/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "LESaleView.h"
#import "UIImage+LEFlatButton.h"
#import "UIColor+LEFlatButton.h"

@implementation LESaleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

#pragma mark -

- (void)setup
{
    for (LEFlatButton *button in self.buttons) {
        [button setFlatTitle:@"1"];
        
        UIImage *image = [UIImage imageFromColor:[[UIColor whiteColor] darkerColor]];
        [button setBackgroundImage:image forState:UIControlStateHighlighted];
        [button setBackgroundImage:image forState:UIControlStateSelected];
    }
}

@end
