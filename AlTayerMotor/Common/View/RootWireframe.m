//
//  RootWireframe.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/14/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "RootWireframe.h"
#import "BaseViewController.h"

@implementation RootWireframe

- (void)showRootViewController:(UIViewController *)viewController
                      inWindow:(UIWindow *)window
{
    UIViewController *rootViewController = [window rootViewController];
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        navigationController.viewControllers = @[viewController];
    } else {
        window.rootViewController = viewController;
    }
}

@end
