//
//  DeleteVehicleWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "DeleteVehicleWireframe.h"
#import "DeleteVehicleViewController.h"
#import "DeleteVehiclePresenter.h"
#import "DeleteVehiclePresentationTransition.h"
#import "DeleteVehicleDismissalTransition.h"
#import "ServicesPresenter.h"
#import "ProfilePresenter.h"
#import "FirstTimePresenter.h"

static NSString *DeleteViewControllerIdentifier = @"DeleteVehicleViewController";

@interface DeleteVehicleWireframe() <UIViewControllerTransitioningDelegate>
@property (strong, nonatomic) UIViewController *presentedViewController;
@end

@implementation DeleteVehicleWireframe

- (void)presentDeleteVehicleInterfaceFromNavigation:(UINavigationController *)nav
                              withServicesPresenter:(ServicesPresenter *)servicesPresenter
                                        withVehicle:(MRegisteredVehicle *)vehicle
{
    DeleteVehiclePresenter *presenter = [DeleteVehiclePresenter new];
    presenter.delegate = servicesPresenter;
    presenter.wireframe = self;
    presenter.vehicle = vehicle;
    DeleteVehicleViewController *deleteViewController = [self addViewController];
    deleteViewController.eventHandler = presenter;
    deleteViewController.modalPresentationStyle = UIModalPresentationCustom;
    deleteViewController.transitioningDelegate = self;
    
    [nav presentViewController:deleteViewController animated:YES completion:nil];
    self.presentedViewController = deleteViewController;
}

- (void)presentDeleteVehicleInterfaceFromNavigation:(UINavigationController *)nav
                              withProfilePresenter:(ProfilePresenter *)profilePresenter
                                        withVehicle:(MRegisteredVehicle *)vehicle
{
    DeleteVehiclePresenter *presenter = [DeleteVehiclePresenter new];
    presenter.delegate = profilePresenter;
    presenter.wireframe = self;
    presenter.vehicle = vehicle;
    DeleteVehicleViewController *deleteViewController = [self addViewController];
    deleteViewController.eventHandler = presenter;
    deleteViewController.modalPresentationStyle = UIModalPresentationCustom;
    deleteViewController.transitioningDelegate = self;
    
    [nav presentViewController:deleteViewController animated:YES completion:nil];
    self.presentedViewController = deleteViewController;
}

- (void)presentDeleteVehicleInterfaceFromNavigation:(UINavigationController *)nav
                             withFirstTimePresenter:(FirstTimePresenter *)firstTimePresenter
                                        withVehicle:(MRegisteredVehicle *)vehicle
{
    DeleteVehiclePresenter *presenter = [DeleteVehiclePresenter new];
    presenter.delegate = firstTimePresenter;
    presenter.wireframe = self;
    presenter.vehicle = vehicle;
    DeleteVehicleViewController *deleteViewController = [self addViewController];
    deleteViewController.eventHandler = presenter;
    deleteViewController.modalPresentationStyle = UIModalPresentationCustom;
    deleteViewController.transitioningDelegate = self;
    
    [nav presentViewController:deleteViewController animated:YES completion:nil];
    self.presentedViewController = deleteViewController;
}

- (void)dismissDeleteInterfaceWithCompletion:(void (^ __nullable)(void))completion
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
        completion();
    }];
}

- (DeleteVehicleViewController *)addViewController
{
    UIStoryboard *storyboard = [self mainStoryboard];
    DeleteVehicleViewController *addViewController = [storyboard instantiateViewControllerWithIdentifier:DeleteViewControllerIdentifier];
    
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
    return [[DeleteVehicleDismissalTransition alloc] init];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [[DeleteVehiclePresentationTransition alloc] init];
}

@end
