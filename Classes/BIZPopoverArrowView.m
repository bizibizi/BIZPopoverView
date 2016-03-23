//
//  BIZPopoverArrowView.m
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 11/5/15.
//  Copyright © 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "BIZPopoverArrowView.h"
#import <QuartzCore/QuartzCore.h>


#define DEGREES_TO_RADIANS(degrees) ((3.14159265359 * degrees) / 180)


@interface BIZPopoverArrowView ()
//! Position of popover
@property (nonatomic) kPopoverPosition popoverPosition;
//! View to that PopoverArrowView will be sticked
@property (nonatomic, strong) UIView *contentView;
//! View to that PopoverArrowView will be pointing
@property (nonatomic, strong) UIView *pointingView;
@end


@implementation BIZPopoverArrowView


#pragma mark - LifeCycle


- (instancetype)initWithContentView:(UIView *)contentView pointingView:(UIView *)pointingView popoverPosition:(kPopoverPosition)popoverPosition
{
    if (self = [super init])
    {
        _contentView = contentView;
        _pointingView = pointingView;
        _popoverPosition = popoverPosition;

        //Default values
        _size = CGSizeMake(30, 18);
        _cornerRadius = 5;
        _arrowHorizontalInset = 0;
        
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        [self updatePosition];
    }
    return self;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self updatePosition];
}

- (void)setSize:(CGSize)size
{
    _size = size;
    [self updatePosition];
}

- (void)setArrowHorizontalInset:(CGFloat)arrowHorizontalInset
{
    _arrowHorizontalInset = arrowHorizontalInset;
    [self updatePosition];
}

//setup arrow frame
- (void)updatePosition
{
    CGFloat x = 0;
    CGFloat y = 0;

    CGPoint point = [self.pointingView.superview convertPoint:self.pointingView.center toView:self.superview];

    switch (self.popoverPosition)
    {
        case kPopoverPositionBottom:
        {
            x = point.x - self.size.width / 2 + self.arrowHorizontalInset;
            y = self.contentView.frame.origin.y - self.size.height;
        }
            break;

        case kPopoverPositionTop:
        {
            x = point.x - self.size.width / 2 + self.arrowHorizontalInset;
            y = self.contentView.frame.origin.y + self.contentView.frame.size.height;
        }
            break;

        default:
            break;
    }

    self.frame = CGRectMake(x, y, self.size.width, self.size.height);

    [self setNeedsDisplay];
}

//draw arrow
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *arrow = [[UIBezierPath alloc] init];
    UIColor *color = self.arrowColor;

    //draw trapeze and half of circle at it's top
    CGPoint trapezeTopLeftPoint = CGPointZero;
    CGPoint trapezeTopRightPoint = CGPointZero;
    CGPoint trapezeBottomLeftPoint = CGPointZero;
    CGPoint trapezeBottomRightPoint = CGPointZero;
    CGPoint circleCenterPoint = CGPointZero;
    CGFloat circleRadius = self.cornerRadius;
    BOOL clockwiseDrawing = NO;

    switch (self.popoverPosition)
    {
        case kPopoverPositionBottom:
        {
            trapezeBottomLeftPoint = CGPointMake(0, rect.size.height);
            trapezeBottomRightPoint = CGPointMake(rect.size.width, rect.size.height);
            trapezeTopLeftPoint = CGPointMake(rect.size.width / 2 - circleRadius, circleRadius);
            trapezeTopRightPoint = CGPointMake(rect.size.width / 2 + circleRadius, circleRadius);
            circleCenterPoint = CGPointMake(rect.size.width / 2, circleRadius * 1.2);
            clockwiseDrawing = YES;
        }
            break;

        case kPopoverPositionTop:
        {
            trapezeBottomLeftPoint = CGPointMake(0, 0);
            trapezeBottomRightPoint = CGPointMake(rect.size.width, 0);
            trapezeTopLeftPoint = CGPointMake(rect.size.width / 2 - circleRadius, rect.size.height - circleRadius);
            trapezeTopRightPoint = CGPointMake(rect.size.width / 2 + circleRadius, rect.size.height - circleRadius);
            circleCenterPoint = CGPointMake(rect.size.width / 2, rect.size.height - circleRadius * 1.2);
            clockwiseDrawing = NO;
        }
            break;

        default:
            break;
    }

    [arrow moveToPoint:trapezeBottomLeftPoint];
    [arrow addLineToPoint:trapezeTopLeftPoint];
    [arrow addArcWithCenter:circleCenterPoint radius:circleRadius startAngle:DEGREES_TO_RADIANS(180.0) endAngle:DEGREES_TO_RADIANS(0.0) clockwise:clockwiseDrawing];
    [arrow addLineToPoint:trapezeTopRightPoint];
    [arrow addLineToPoint:trapezeBottomRightPoint];
    [arrow closePath];

    [color setFill];
    [arrow fill];
}

@end