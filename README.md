# BIZPopoverView

*Wait for gif presentation, it's loading...*

![alt tag](https://github.com/bizibizi/BIZPopoverView/blob/master/presentation.gif)


BIZPopoverView is a custom popover as ContentView of that can be used any content of any UIViewController.  


# Installation

### Manually
- Copy ```Classes``` folder to your project 

### From CocoaPods:
```objective-c
pod 'BIZPopoverView' 
```


# Usage

- create custom UIViewController that will be used as ContentView for popover
![alt tag](https://github.com/bizibizi/BIZPopoverView/blob/master/example1.png)
- ```#import "BIZPopoverViewController.h"``` 
- create, setup and present popover
```objective-c
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
```


# Contact

Igor Bizi
- https://www.linkedin.com/in/igorbizi
- igorbizi@mail.ru


# License
 
The MIT License (MIT)

Copyright (c) 2015-present Igor Bizi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
