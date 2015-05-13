//
//  LENumberPad.m
//  LEAmountInputView
//
//  Created by Lasha Efremidze on 5/13/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import "LENumberPad.h"
#import "LENumberPadCollectionViewCell.h"
#import "UIImage+LENumberPad.h"

@interface LENumberPad () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LENumberPad

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize;
{
    self.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - Override Properties

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *collectionViewLayout = [UICollectionViewFlowLayout new];
        collectionViewLayout.minimumLineSpacing = 0.5f;
        collectionViewLayout.minimumInteritemSpacing = 0.5f;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:collectionViewLayout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.allowsSelection = NO;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[LENumberPadCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([LENumberPadCollectionViewCell class])];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self numberOfColumns] * [self numberOfRows];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    LENumberPadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LENumberPadCollectionViewCell class]) forIndexPath:indexPath];
    
    NSString *title = [self buttonTitleForButtonAtIndexPath:indexPath];
    [cell.button setTitle:title forState:UIControlStateNormal];
    
    UIColor *titleColor = [self buttonTitleColorForButtonAtIndexPath:indexPath];
    [cell.button setTitleColor:titleColor forState:UIControlStateNormal];
    
    UIFont *font = [self buttonTitleFontForButtonAtIndexPath:indexPath];
    cell.button.titleLabel.font = font;
    
    UIColor *backgroundColor = [self buttonBackgroundColorForButtonAtIndexPath:indexPath];
    UIImage *backgroundImage = [UIImage imageFromColor:backgroundColor];
    [cell.button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    backgroundColor = [self buttonBackgroundHighlightedColorForButtonAtIndexPath:indexPath];
    backgroundImage = [UIImage imageFromColor:backgroundColor];
    [cell.button setBackgroundImage:backgroundImage forState:UIControlStateHighlighted];
    [cell.button setBackgroundImage:backgroundImage forState:UIControlStateSelected];
    
    [cell.button addTarget:self action:@selector(didTouchOnButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    CGFloat width = collectionView.frame.size.width / [self numberOfColumns];
    CGFloat height = collectionView.frame.size.height / [self numberOfRows];
    return (CGSize){width - collectionViewLayout.minimumInteritemSpacing, height - collectionViewLayout.minimumLineSpacing};
}

#pragma mark - IBActions

- (IBAction)didTouchOnButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(numberPad:didSelectButtonAtIndexPath:)]) {
        [self.delegate numberPad:self didSelectButtonAtIndexPath:[self indexPathForButton:button]];
    }
}

#pragma mark - Helpers

- (UIButton *)buttonAtIndexPath:(NSIndexPath *)indexPath;
{
    LENumberPadCollectionViewCell *cell = (LENumberPadCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    return cell.button;
}

- (NSIndexPath *)indexPathForButton:(UIButton *)button;
{
    CGPoint point = [button convertPoint:CGPointZero toView:self.collectionView];
    return [self.collectionView indexPathForItemAtPoint:point];
}

#pragma mark - Private

- (NSInteger)numberOfColumns;
{
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsInNumberPad:)]) {
        return [self.dataSource numberOfColumnsInNumberPad:self];
    }
    return 3;
}

- (NSInteger)numberOfRows;
{
    if ([self.dataSource respondsToSelector:@selector(numberOfRowsInNumberPad:)]) {
        return [self.dataSource numberOfRowsInNumberPad:self];
    }
    return 4;
}

- (NSString *)buttonTitleForButtonAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([self.dataSource respondsToSelector:@selector(numberPad:buttonTitleForButtonAtIndexPath:)]) {
        return [self.dataSource numberPad:self buttonTitleForButtonAtIndexPath:indexPath];
    } else if (indexPath.item == 9) {
        return @"C";
    } else if (indexPath.item == 10) {
        return @"0";
    } else if (indexPath.item == 11) {
        return @"00";
    }
    return [NSString stringWithFormat:@"%lu", indexPath.item + 1];
}

- (UIColor *)buttonTitleColorForButtonAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([self.dataSource respondsToSelector:@selector(numberPad:buttonTitleColorForButtonAtIndexPath:)]) {
        return [self.dataSource numberPad:self buttonTitleColorForButtonAtIndexPath:indexPath];
    } else if (indexPath.item == 9) {
        return [UIColor orangeColor];
    }
    return [UIColor colorWithWhite:0.3f alpha:1.0f];
}

- (UIFont *)buttonTitleFontForButtonAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([self.dataSource respondsToSelector:@selector(numberPad:buttonTitleFontForButtonAtIndexPath:)]) {
        return [self.dataSource numberPad:self buttonTitleFontForButtonAtIndexPath:indexPath];
    }
    return [UIFont systemFontOfSize:40.0f];
}

- (UIColor *)buttonBackgroundColorForButtonAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([self.dataSource respondsToSelector:@selector(numberPad:buttonBackgroundColorForButtonAtIndexPath:)]) {
        return [self.dataSource numberPad:self buttonBackgroundColorForButtonAtIndexPath:indexPath];
    }
    return [UIColor whiteColor];
}

- (UIColor *)buttonBackgroundHighlightedColorForButtonAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([self.dataSource respondsToSelector:@selector(numberPad:buttonBackgroundHighlightedColorForButtonAtIndexPath:)]) {
        return [self.dataSource numberPad:self buttonBackgroundHighlightedColorForButtonAtIndexPath:indexPath];
    }
    return [UIColor colorWithWhite:0.9f alpha:1.0f];
}

@end
