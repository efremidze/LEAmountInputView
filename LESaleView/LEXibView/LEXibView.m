//
//  LEXibView.m
//  LESaleView
//
//  Created by Lasha Efremidze on 4/29/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "LEXibView.h"

@implementation LEXibView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _xibView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        if (CGRectIsEmpty(frame))
            self.bounds = _xibView.bounds;
        [self addSubview:_xibView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        if (!self.subviews.count) {
            _xibView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
            [self addSubview:_xibView];
        }
    }
    return self;
}

@end
