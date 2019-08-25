//
//  InsuranceConfirmationWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/16/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "InsuranceConfirmationWireframe.h"
#import "InsuranceConfirmationViewController.h"
#import "InsuranceConfirmationPresenter.h"
#import "InsurancePresenter.h"

static NSString *InsuranceConfirmationViewControllerIdentifier = @"InsuranceConfirmationViewController";

@implementation InsuranceConfirmationWireframe

- (void)presentInsuranceConfirmationInterfaceFromPresenter:(InsurancePresenter *)insurancePresenter
{
    InsuranceConfirmationPresenter *presenter = [InsuranceConfirmationPresenter new];
    InsuranceConfirmationViewController *insuranceVC = [self insuranceViewControllerFromStoryboard];
    insuranceVC.eventHandler = presenter;
    presenter.wireframe = self;
    presenter.userInterface = insuranceVC;
    presenter.insurancePresenter = insurancePresenter;
    
    [insurancePresenter.userInterface.navigationController pushViewController:insuranceVC
                                                                     animated:YES];
}

- (InsuranceConfirmationViewController *)insuranceViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    InsuranceConfirmationViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:InsuranceConfirmationViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Insurance"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
