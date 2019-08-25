//
//  ServiceConfirmationPresenter.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/4/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ServiceConfirmationPresenter.h"
#import "ATMTabBarViewController.h"
#import "BookingServicePresenter.h"
#import "BookingServiceViewInterface.h"

@implementation ServiceConfirmationPresenter

- (void)backToPreowned
{
    // Change tab
    ATMTabBarViewController *tabBarController = (ATMTabBarViewController *) self.userInterface.tabBarController;
    UINavigationController *nc = [tabBarController getPreownedTab];
    if ([nc isKindOfClass:[UINavigationController class]]) {
        [nc popToRootViewControllerAnimated:NO];
    }
    
    // reset this insurance
    [self.userInterface.navigationController popToRootViewControllerAnimated:NO];
}

@end
