# LEAmountInputView

[![CI Status](http://img.shields.io/travis/efremidze/LEAmountInputView.svg?style=flat)](https://travis-ci.org/efremidze/LEAmountInputView)
[![Version](https://img.shields.io/cocoapods/v/LEAmountInputView.svg?style=flat)](http://cocoapods.org/pods/LEAmountInputView)
[![License](https://img.shields.io/cocoapods/l/LEAmountInputView.svg?style=flat)](http://cocoapods.org/pods/LEAmountInputView)
[![Platform](https://img.shields.io/cocoapods/p/LEAmountInputView.svg?style=flat)](http://cocoapods.org/pods/LEAmountInputView)

## Overview

`LEAmountInputView` is an amount input view inspired by Square's design.

![LEAmountInputView Screenshot](Screenshots/example.gif)

## Installation

LEAmountInputView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LEAmountInputView"
```

## Usage

### Import

```objc
#import "LEAmountInputView.h"
```

### Example

```objectivec

LEAmountInputView *amountInputView = [[LEAmountInputView alloc] initWithFrame:self.view.bounds numberStyle:NSNumberFormatterCurrencyStyle];
amountInputView.delegate = self;
[self.view addSubview:amountInputView];

```

### Storyboard

Works with storyboard.

### Optional

You can use `LEAmountInputViewDelegate` to observe input.

For more details, see the `LEAmountInputViewDemo` project;

## Contributions

Contributions are totally welcome.

## License

LESaleView is available under the MIT license. See the LICENSE file for more info.
