//
//  BIZPopoverViewControllerDelegate.h
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 11/27/15.
//  Copyright © 2015 IgorBizi@mail.ru. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol BIZPopoverViewControllerDelegate <NSObject>
@optional
- (void)popoverViewControllerWillDismiss;
- (void)popoverViewControllerDidDismiss;
- (void)popoverViewControllerWillChangeOrientation;
@end

