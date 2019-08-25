//
//  BookingConfirmationPresenter.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/18/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BookingConfirmationPresenter.h"
#import "ATMTabBarViewController.h"
#import "BookingTestPresenter.h"
#import "BookingTestViewInterface.h"
@implementation BookingConfirmationPresenter

- (void)backToPreowned
{
    // Change tab
    ATMTabBarViewController *tabBarController = (ATMTabBarViewController *) self.userInterface.tabBarController;
    UINavigationController *nc = [tabBarController getPreownedTab];
    if ([nc isKindOfClass:[UINavigationController class]]) {
        [nc popToRootViewControllerAnimated:NO];
    }
    
    // reset this insurance
    [self.userInterface.navigationController popViewControllerAnimated:NO];
    [self.bookingPresenter.userInterface didClearForm];
}

@end
