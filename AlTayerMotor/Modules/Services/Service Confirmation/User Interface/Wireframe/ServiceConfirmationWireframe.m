//
//  ServiceConfirmationWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ServiceConfirmationWireframe.h"
#import "ServiceConfirmationViewController.h"
#import "ServiceConfirmationPresenter.h"

static NSString *ServiceConfirmationViewControllerIdentifier = @"ServiceConfirmationViewController";

@implementation ServiceConfirmationWireframe

- (void)pushConfirmationInterfaceToController:(UINavigationController *)navigationController
                                  withRequest:(MServiceRequest *)request
{
    ServiceConfirmationPresenter *presenter = [ServiceConfirmationPresenter new];
    ServiceConfirmationViewController *confirmationVC = [self confirmationViewControllerFromStoryboard];
    confirmationVC.serviceRequest = request;
    confirmationVC.eventHandler = presenter;
    presenter.userInterface = confirmationVC;
    presenter.wireframe = self;
    [navigationController pushViewController:confirmationVC
                                    animated:YES];
    
}

- (ServiceConfirmationViewController *)confirmationViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self servicesStoryboard];
    ServiceConfirmationViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:ServiceConfirmationViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)servicesStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Services"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
