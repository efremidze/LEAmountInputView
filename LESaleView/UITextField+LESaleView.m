//
//  UITextField+LESaleView.m
//  LESaleView
//
//  Created by Lasha Efremidze on 4/30/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "UITextField+LESaleView.h"

@implementation UITextField (LESaleView)

- (NSRange)selectedRange;
{
    UITextRange *selectedTextRange = [self selectedTextRange];
    NSInteger start = [self offsetFromPosition:self.beginningOfDocument toPosition:selectedTextRange.start];
    NSInteger end = [self offsetFromPosition:self.beginningOfDocument toPosition:selectedTextRange.end];
    return NSMakeRange(start, end - start);
}

@end
