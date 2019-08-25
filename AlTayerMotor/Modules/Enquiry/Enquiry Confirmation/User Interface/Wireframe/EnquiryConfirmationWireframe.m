//
//  EnquiryConfirmationWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "EnquiryConfirmationWireframe.h"
#import "EnquiryConfirmationViewCtroller.h"
#import "EnquiryConfirmationPresenter.h"


static NSString *EnquiryConfirmationViewCtrollerIdentifier = @"EnquiryConfirmationViewCtroller";

@implementation EnquiryConfirmationWireframe

- (void)presentInsuranceConfirmationInterfaceInNavigationController:(UINavigationController *)navController
{
    EnquiryConfirmationPresenter *presenter = [EnquiryConfirmationPresenter new];
    EnquiryConfirmationViewCtroller *enquiryConfirmationVC = [self enquiryConfirmationViewControllerFromStoryboard];
    enquiryConfirmationVC.eventHandler = presenter;
    presenter.wireframe = self;
    presenter.userInterface = enquiryConfirmationVC;
    
    [navController pushViewController:enquiryConfirmationVC
                             animated:YES];
}

- (EnquiryConfirmationViewCtroller *)enquiryConfirmationViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    EnquiryConfirmationViewCtroller *viewController = [storyboard instantiateViewControllerWithIdentifier:EnquiryConfirmationViewCtrollerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Enquiry"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
