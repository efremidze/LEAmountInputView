# LEAmountInputView

[![CI Status](http://img.shields.io/travis/efremidze/LEAmountInputView.svg?style=flat)](https://travis-ci.org/efremidze/LEAmountInputView)
[![Version](https://img.shields.io/cocoapods/v/LEAmountInputView.svg?style=flat)](http://cocoapods.org/pods/LEAmountInputView)
[![License](https://img.shields.io/cocoapods/l/LEAmountInputView.svg?style=flat)](http://cocoapods.org/pods/LEAmountInputView)
[![Platform](https://img.shields.io/cocoapods/p/LEAmountInputView.svg?style=flat)](http://cocoapods.org/pods/LEAmountInputView)

## Overview

`LEAmountInputView` is an amount input view inspired by Square's design.

![LEAmountInputView Screenshot](Screenshots/example.gif)

**Note:** If you like `LEAmountInputView`, checkout [NumPad](https://github.com/efremidze/NumPad).

## Installation

LEAmountInputView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LEAmountInputView"
```

## Usage

See the `LEAmountInputViewDemo` project for example usage.

### Import

```objc
#import "LEAmountInputView.h"
```

### Example

```objectivec
LEAmountInputView *amountInputView = [[LEAmountInputView alloc] initWithFrame:self.view.frame numberStyle:NSNumberFormatterCurrencyStyle];
[self.view addSubview:amountInputView];
```

### LEAmountInputTextField

If you want to use the textField standalone with the numberPad as an inputView, use `LEAmountInputTextField`.

## Contributions

Contributions are totally welcome.

## License

LEAmountInputView is available under the MIT license. See the LICENSE file for more info.
