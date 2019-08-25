//
//  InsuranceConfirmationPresenter.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/16/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "InsuranceConfirmationPresenter.h"
#import "ATMTabBarViewController.h"
#import "InsurancePresenter.h"

@implementation InsuranceConfirmationPresenter

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
    [self.insurancePresenter.userInterface didClearForm];
}

@end
