//
//  BookingConfirmationWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/18/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BookingConfirmationWireframe.h"
#import "BookingConfirmationPresenter.h"
#import "BookingConfirmationViewController.h"
#import "BookingTestPresenter.h"

static NSString *BookingConfirmationViewControllerIdentifier = @"BookingConfirmationViewController";

@implementation BookingConfirmationWireframe

- (void)presentBookingConfirmationInterfaceFromPresenter:(BookingTestPresenter *)presenter
                                             withRequest:(MBookingTestRequest *)request
{
    BookingConfirmationPresenter *bookingPresenter = [BookingConfirmationPresenter new];
    BookingConfirmationViewController *bookingConfirmationVC = [self insuranceViewControllerFromStoryboard];
    bookingConfirmationVC.eventHandler = bookingPresenter;
    bookingConfirmationVC.request = request;
    bookingPresenter.wireframe = self;
    bookingPresenter.userInterface = bookingConfirmationVC;
    bookingPresenter.bookingPresenter = presenter;
    
    [presenter.userInterface.navigationController pushViewController:bookingConfirmationVC
                                                                     animated:YES];
}

- (BookingConfirmationViewController *)insuranceViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    BookingConfirmationViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:BookingConfirmationViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BookingTest"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}


@end
