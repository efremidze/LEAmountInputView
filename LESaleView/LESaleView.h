//
//  LESaleView.h
//  LESaleView
//
//  Created by Lasha Efremidze on 4/29/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEXibView.h"
#import "LEFlatButton.h"

@interface LESaleView : LEXibView

@property (nonatomic, strong) IBOutletCollection(LEFlatButton) NSArray *buttons;

@end
