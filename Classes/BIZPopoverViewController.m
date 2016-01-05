//
//  BIZPopoverViewController.m
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 10/12/15.
//  Copyright © 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "BIZPopoverViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIViewController+BIZChildViewController.h"
#import "BIZPopoverArrowView.h"


#define kDuration_animation 0.28


@interface BIZPopoverViewController ()
//! Size of content
@property (nonatomic) CGSize contentSize;
//! View from that popover presentation will be occur
@property (nonatomic) UIView *pointingView;
//! Direction of popover arrow
@property (nonatomic) kPopoverPosition popoverPosition;
//! ContentViewController
@property (nonatomic, strong) UIViewController *contentViewController;
@end


@implementation BIZPopoverViewController


#pragma mark - Class


+ (UIColor *)kColor_modalBackground
{
    return [UIColor colorWithRed:29/255.0 green:39/255.0 blue:57/255.0 alpha:0.7];
}

+ (UIColor *)kColor_modalBackgroundClear
{
    return [[self kColor_modalBackground] colorWithAlphaComponent:0.0];
}

+ (CGFloat)kCornerRadius
{
    return 4.0;
}

#pragma mark - LifeCycle


- (instancetype)initWithContentViewController:(UIViewController *)contentViewController contentSize:(CGSize)contentSize pointingView:(UIView *)pointingView popoverPosition: (kPopoverPosition)popoverPosition
{
    if (self = [super init])
    {
        _contentViewController = contentViewController;
        _contentSize = contentSize;
        _pointingView = pointingView;
        _popoverPosition = popoverPosition;
        
        // Default values
        _alignment = kPopoverAlignmentLeft;
        _indentHorizontal = 0;
        _indentVertical = 0;
        _dismissDelay = 0.2;
        
        self.popoverArrowView = [[BIZPopoverArrowView alloc] initWithContentView:_contentViewController.view pointingView:pointingView popoverPosition:_popoverPosition];
        self.popoverArrowView.cornerRadius = [[self class] kCornerRadius];
        self.popoverArrowView.arrowColor = self.contentViewController.view.backgroundColor;
        [self.view addSubview:self.popoverArrowView];

        [self containerAddChildViewController:_contentViewController];

        self.modalPresentationStyle = UIModalPresentationOverFullScreen;

        [self setupContentViewPosition];
    }
    return self;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self setupContentViewPosition];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.contentViewController.view.layer.cornerRadius = [[self class] kCornerRadius];
    self.contentViewController.view.layer.masksToBounds = YES;

    [self loadVisibleState:NO];
    [self createGestureEvents];
}

- (void)createGestureEvents
{
    UITapGestureRecognizer *gestureRecognizerView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopoverViewControllerAnimatedPassiveAction)];
    gestureRecognizerView.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:gestureRecognizerView];
    
    for (UIView *i in [self subviews])
    {
        UITapGestureRecognizer *gestureRecognizerContentViewItem = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
        gestureRecognizerContentViewItem.numberOfTouchesRequired = 1;
        [gestureRecognizerContentViewItem setCancelsTouchesInView:NO];
        [i addGestureRecognizer:gestureRecognizerContentViewItem];
        [gestureRecognizerView requireGestureRecognizerToFail:gestureRecognizerContentViewItem];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startAppearance];
}

#pragma mark - Properties


- (void)setAlignment:(kPopoverAlignment)alignment
{
    _alignment = alignment;
    [self setupContentViewPosition];
}

- (void)setIndentHorizontal:(CGFloat)indentHorizontal
{
    _indentHorizontal = indentHorizontal;
    [self setupContentViewPosition];
}

- (void)setIndentVertical:(CGFloat)indentVertical
{
    _indentVertical = indentVertical;
    [self setupContentViewPosition];
}

- (void)setPopoverSuperview:(UIView *)popoverSuperview
{
    _popoverSuperview = popoverSuperview;
    [self setupContentViewPosition];
}

- (void)setupContentViewPosition
{
    CGFloat x = 0;
    CGFloat y = 0;

    CGRect frame = [self.pointingView convertRect:self.pointingView.bounds toView:self.view];

    switch (self.popoverPosition)
    {
        case kPopoverPositionBottom:
        {
            y = frame.size.height + frame.origin.y + self.indentVertical + self.popoverArrowView.size.height;
        }
            break;

        case kPopoverPositionTop:
        {
            y = frame.origin.y - self.indentVertical - self.contentSize.height - self.popoverArrowView.size.height;
        }
            break;

        default:
            break;
    }

    switch (self.alignment)
    {
        case kPopoverAlignmentLeft:
        {
            x = self.indentHorizontal;
        }
            break;

        case kPopoverAlignmentRight:
        {
            x = self.popoverSuperview.frame.size.width - self.contentSize.width - self.indentHorizontal;
        }
            break;

        default:
            break;
    }

    self.contentViewController.view.frame = CGRectMake(x, y, self.contentSize.width, self.contentSize.height);
    [self.popoverArrowView updatePosition];
}

#pragma mark - Events


- (void)startAppearance
{
    [UIView animateWithDuration:kDuration_animation
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
                         [self loadVisibleState:YES];
                     }
                     completion:nil];
}

- (void)dismissPopoverViewControllerAnimated:(BOOL)animated
{
    [self dismissPopoverViewControllerAnimated:animated afterDelay:NO];
}

- (void)dismissPopoverViewControllerAnimated:(BOOL)animated afterDelay:(BOOL)delay
{
    [self dismissPopoverViewControllerAnimated:animated afterDelay:delay completion:nil];
}

- (void)dismissPopoverViewControllerAnimated:(BOOL)animated afterDelay:(BOOL)delay completion:(void (^)(void))completion
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(popoverViewControllerWillDismiss)]) {
        [self.delegate popoverViewControllerWillDismiss];
    }
    
    CGFloat delaySec = delay? self.dismissDelay : 0.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:animated? kDuration_animation : 0.0
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             [self loadVisibleState:NO];
                         } completion:^(BOOL finished) {
                             
                             [self containerRemoveChildViewController:self.contentViewController];
                             [self.presentingViewController dismissViewControllerAnimated:NO completion:^{
                                 
                                 if (self.delegate && [self.delegate respondsToSelector:@selector(popoverViewControllerDidDismiss)]) {
                                     [self.delegate popoverViewControllerDidDismiss];
                                 }
                                 
                                 if (completion) {
                                     completion();
                                 }
                             }];
                         }];
    });
}

- (void)dismissPopoverViewControllerAnimatedPassiveAction
{
    [self dismissPopoverViewControllerAnimated:YES afterDelay:NO];
}

- (void)loadVisibleState:(BOOL)visible
{
    if (visible) {
        for (UIView *i in [self subviews])
        {
            i.alpha = 1.0;
        }
        self.view.backgroundColor = [[self class] kColor_modalBackground];
    } else {
        for (UIView *i in [self subviews])
        {
            i.alpha = 0.0;
        }
        self.view.backgroundColor = [[self class] kColor_modalBackgroundClear];
    }
}

//! Items that are part of content view
- (NSArray *)subviews
{
    return @[self.contentViewController.view, self.popoverArrowView];
}


#pragma mark - Rotation Delegate


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(popoverViewControllerWillChangeOrientation)]) {
        [self.delegate popoverViewControllerWillChangeOrientation];
    }
}





@end