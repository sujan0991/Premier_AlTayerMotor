//
//  BaseViewController.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/14/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+EmptyBackButton.h"
#import "UIViewController+MMDrawerController.h"

@class MenuViewController;
@class DGActivityIndicatorView;

@interface BaseViewController : UIViewController

@property (nonatomic, strong) MenuViewController *menuVC;

- (void)addRightMenuWithAction:(SEL)action inController:(UIViewController*)controller;
- (void)addLeftMenuWithAction:(SEL)action inController:(UIViewController*)controller;
- (IBAction)toggleMenu:(id)sender;
- (void)showMessage:(NSString *)message;
- (void)showBlankMessage:(NSString *)field;

- (void)activeAllTabBarItems;
- (void)deactiveAllTabBarItems;

- (void)hideLoadingEndicator;
- (void)showLoadingIndicator;
@end
