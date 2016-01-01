//
//  BIZPopoverArrowView.h
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 11/5/15.
//  Copyright © 2015 IgorBizi@mail.ru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BIZConstants.h"


@interface BIZPopoverArrowView : UIView
//! DESIGNATED INITIALIZER
- (instancetype)initWithContentView:(UIView *)contentView pointingView:(UIView *)pointingView popoverPosition:(kPopoverPosition)popoverPosition;

//! Corner radius of arrow
@property (nonatomic) CGFloat cornerRadius;
//! Horizontal inset of popover arrow
@property (nonatomic) CGFloat arrowHorizontalInset;
//! Size of arrow
@property (nonatomic) CGSize size;
//! Color of arrow
@property (nonatomic, strong) UIColor *arrowColor;


- (void)updatePosition;
@end