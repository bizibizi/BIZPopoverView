//
//  ViewController.m
//  Example
//
//  Created by IgorBizi@mail.ru on 12/16/15.
//  Copyright © 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "ViewController.h"
#import "BIZPopoverViewController.h"


@interface ViewController ()
@end


@implementation ViewController


- (IBAction)showPopoverTopButtonActioon:(UIButton *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *smallViewController = [storyboard instantiateViewControllerWithIdentifier:@"smallViewController"];

    BIZPopoverViewController *popoverViewController =
    [[BIZPopoverViewController alloc] initWithContentViewController:smallViewController
                                                     contentSize:CGSizeMake(200, 100)
                                                    pointingView:sender
                                                 popoverPosition:kPopoverPositionBottom];
//    popoverViewController.delegate = self;
    popoverViewController.alignment = kPopoverAlignmentLeft;
    popoverViewController.indentHorizontal = 15;
    popoverViewController.indentVertical = 0;
    popoverViewController.popoverSuperview = self.view;
    [self presentViewController:popoverViewController animated:NO completion:nil];
}

- (IBAction)showPopoverBottonCenterButtonAction:(UIButton *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *smallViewController = [storyboard instantiateViewControllerWithIdentifier:@"tableViewController"];
    
    BIZPopoverViewController *popoverViewController =
    [[BIZPopoverViewController alloc] initWithContentViewController:smallViewController
                                                        contentSize:CGSizeMake(250, 300)
                                                       pointingView:sender
                                                    popoverPosition:kPopoverPositionTop];
    //    popoverViewController.delegate = self;
    popoverViewController.alignment = kPopoverAlignmentLeft;
    popoverViewController.indentHorizontal = (self.view.bounds.size.width - 250)/2;
    popoverViewController.indentVertical = 0;
    popoverViewController.popoverSuperview = self.view;
    [self presentViewController:popoverViewController animated:NO completion:nil];
}

- (IBAction)showPopoverBottomRightButtonAction:(UIButton *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *smallViewController = [storyboard instantiateViewControllerWithIdentifier:@"tableViewController"];
    
    BIZPopoverViewController *popoverViewController =
    [[BIZPopoverViewController alloc] initWithContentViewController:smallViewController
                                                        contentSize:CGSizeMake(250, 150)
                                                       pointingView:sender
                                                    popoverPosition:kPopoverPositionTop];
    //    popoverViewController.delegate = self;
    popoverViewController.alignment = kPopoverAlignmentRight;
    popoverViewController.indentHorizontal = 10;
    popoverViewController.indentVertical = 0;
    popoverViewController.popoverSuperview = self.view;
    [self presentViewController:popoverViewController animated:NO completion:nil];
}


@end
