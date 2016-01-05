//
//  BIZPopoverViewController.h
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 10/12/15.
//  Copyright © 2015 IgorBizi@mail.ru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BIZPopoverViewControllerDelegate.h"
@class BIZPopoverArrowView;
#import "BIZConstants.h"


@interface BIZPopoverViewController : UIViewController
//! DESIGNATED INITIALIZER
- (instancetype)initWithContentViewController:(UIViewController *)contentViewController contentSize:(CGSize)contentSize pointingView:(UIView *)pointingView popoverPosition: (kPopoverPosition)popoverPosition;
@property (nonatomic, weak) id <BIZPopoverViewControllerDelegate> delegate;
- (void)dismissPopoverViewControllerAnimated:(BOOL)animated;
- (void)dismissPopoverViewControllerAnimated:(BOOL)animated afterDelay:(BOOL)delay;
- (void)dismissPopoverViewControllerAnimated:(BOOL)animated afterDelay:(BOOL)delay completion:(void (^)(void))completion;

//! Alignment for popover
@property (nonatomic) kPopoverAlignment alignment;
//! Indent from contentSuperView edge
@property (nonatomic) CGFloat indentHorizontal;
//! Indent from pointingView edge
@property (nonatomic) CGFloat indentVertical;
//! View from that popover will be presented
@property (nonatomic, strong) UIView *popoverSuperview;
//! Arrow that points to pointingView
@property (nonatomic, strong) BIZPopoverArrowView *popoverArrowView;
//! Dismiss delay in seconds. Default 0.2
@property (nonatomic) NSTimeInterval dismissDelay;

//* Subclass for customization
+ (UIColor *)kColor_modalBackground;
+ (UIColor *)kColor_modalBackgroundClear;
+ (CGFloat)kCornerRadius;

@end