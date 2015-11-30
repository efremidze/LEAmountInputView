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

@interface LENumberPad () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

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
    
    NSDictionary *views = @{@"collectionView": self.collectionView};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[collectionView]|" options:0 metrics:0 views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]|" options:0 metrics:0 views:views]];
}

- (void)layoutSubviews
{
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    [super layoutSubviews];
}

#pragma mark - Override Properties

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *collectionViewLayout = [UICollectionViewFlowLayout new];
        collectionViewLayout.minimumLineSpacing = 1.0f;
        collectionViewLayout.minimumInteritemSpacing = 1.0f;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewLayout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
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
    NSInteger items = 0;
    for (int i = 0; i < [self numberOfRows]; i++) {
        items += [self numberOfColumnsInRow: i];
    }
    return items;
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
    NSInteger numberOfRows = [self numberOfRows];
    NSInteger row = [self rowForIndexPath:indexPath];
    NSInteger numberOfColumns = [self numberOfColumnsInRow:row];
    
    CGFloat width = collectionView.frame.size.width / numberOfColumns;
    CGFloat height = collectionView.frame.size.height / numberOfRows;
    
    CGFloat interitemSpacing = collectionViewLayout.minimumInteritemSpacing * (((float)numberOfColumns - 1.0f) / (float)numberOfColumns);
    CGFloat lineSpacing = collectionViewLayout.minimumLineSpacing * (((float)numberOfRows - 1.0f) / (float)numberOfRows);
    
    CGSize size = (CGSize){width - interitemSpacing, height - lineSpacing};
    
    if ([self.dataSource respondsToSelector:@selector(numberPad:buttonSizeForButtonAtIndexPath:defaultSize:)]) {
        return [self.dataSource numberPad:self buttonSizeForButtonAtIndexPath:indexPath defaultSize:size];
    }
    
    return size;
}

#pragma mark - IBActions

- (IBAction)didTouchOnButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(numberPad:didSelectButtonAtIndexPath:)]) {
        NSIndexPath *indexPath = [self indexPathForButton:button];
        [self.delegate numberPad:self didSelectButtonAtIndexPath:indexPath];
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

- (NSInteger)numberOfRows;
{
    return [self.dataSource numberOfRowsInNumberPad:self];
}

- (NSInteger)numberOfColumnsInRow:(NSInteger)row;
{
    return [self.dataSource numberPad:self numberOfColumnsInRow:row];
}

- (NSInteger)rowForIndexPath:(NSIndexPath *)indexPath;
{
    NSInteger item = 0;
    NSInteger row = -1;
    do {
        item += [self numberOfColumnsInRow:++row];
    } while (item <= indexPath.item);
    return row;
}

#pragma mark - Private

- (NSString *)buttonTitleForButtonAtIndexPath:(NSIndexPath *)indexPath;
{
    return [self.dataSource numberPad:self buttonTitleForButtonAtIndexPath:indexPath];
}

- (UIColor *)buttonTitleColorForButtonAtIndexPath:(NSIndexPath *)indexPath;
{
    return [self.dataSource numberPad:self buttonTitleColorForButtonAtIndexPath:indexPath];
}

- (UIFont *)buttonTitleFontForButtonAtIndexPath:(NSIndexPath *)indexPath;
{
    return [self.dataSource numberPad:self buttonTitleFontForButtonAtIndexPath:indexPath];
}

- (UIColor *)buttonBackgroundColorForButtonAtIndexPath:(NSIndexPath *)indexPath;
{
    return [self.dataSource numberPad:self buttonBackgroundColorForButtonAtIndexPath:indexPath];
}

- (UIColor *)buttonBackgroundHighlightedColorForButtonAtIndexPath:(NSIndexPath *)indexPath;
{
    return [self.dataSource numberPad:self buttonBackgroundHighlightedColorForButtonAtIndexPath:indexPath];
}

@end
