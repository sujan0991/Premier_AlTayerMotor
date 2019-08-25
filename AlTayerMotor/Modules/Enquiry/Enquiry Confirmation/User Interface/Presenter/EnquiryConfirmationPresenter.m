//
//  EnquiryConfirmationPresenter.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "EnquiryConfirmationPresenter.h"
#import "ATMTabBarViewController.h"

@implementation EnquiryConfirmationPresenter

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
