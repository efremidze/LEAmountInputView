//
//  LESaleView.h
//  LESaleView
//
//  Created by Lasha Efremidze on 4/29/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LESaleView : UIView

@property (nonatomic, weak) IBOutlet UIView *headerView;

@property (nonatomic, weak) IBOutlet UITextField *textField;

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *buttons;

@property (nonatomic, strong) NSLocale *locale;

@end
