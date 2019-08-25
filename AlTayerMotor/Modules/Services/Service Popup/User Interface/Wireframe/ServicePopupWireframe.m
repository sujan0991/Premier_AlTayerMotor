//
//  ServicePopupWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ServicePopupWireframe.h"
#import "ServicePopupViewController.h"
#import "ServicePopupPresenter.h"
#import "ServicePopupPresentationTransition.h"
#import "ServicePopupDismissalTransition.h"
#import "BookingServicePresenter.h"

static NSString *AddViewControllerIdentifier = @"ServicePopupViewController";

@interface ServicePopupWireframe() <UIViewControllerTransitioningDelegate>
@property (strong, nonatomic) UIViewController *presentedViewController;
@end

@implementation ServicePopupWireframe

- (void)presentAddInterfaceFromViewController:(UIViewController *)viewController
                  withBookingServicePresenter:(BookingServicePresenter *)bookingPresenter
{
    DLog(@"%@", bookingPresenter ? @"YES" : @"NO");
    ServicePopupPresenter *presenter = [ServicePopupPresenter new];
    presenter.delegate = bookingPresenter;
    presenter.wireframe = self;
    ServicePopupViewController *addViewController = [self addViewController];
    addViewController.eventHandler = presenter;
    addViewController.modalPresentationStyle = UIModalPresentationCustom;
    addViewController.transitioningDelegate = self;
    
    [viewController presentViewController:addViewController animated:YES completion:nil];
    
    self.presentedViewController = viewController;
}

- (void)dismissAddInterface
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (ServicePopupViewController *)addViewController
{
    UIStoryboard *storyboard = [self mainStoryboard];
    ServicePopupViewController *addViewController = [storyboard instantiateViewControllerWithIdentifier:AddViewControllerIdentifier];
    
    return addViewController;
}


- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Services"
                                                         bundle:[NSBundle mainBundle]];
    
    return storyboard;
}


#pragma mark - UIViewControllerTransitioningDelegate Methods

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[ServicePopupDismissalTransition alloc] init];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [[ServicePopupPresentationTransition alloc] init];
}

@end
