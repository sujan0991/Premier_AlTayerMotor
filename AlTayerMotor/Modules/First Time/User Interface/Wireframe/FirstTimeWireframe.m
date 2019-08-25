//
//  FirstTimeWireframe.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/15/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "FirstTimeWireframe.h"
#import "RootWireframe.h"
#import "TabBarWireframe.h"
#import "FirstTimePresenter.h"
#import "FirstTimeViewController.h"
#import "AppDelegate.h"
#import "EditRegisteredVehicleWireframe.h"
#import "DeleteVehicleWireframe.h"

static NSString *FirstTimeViewControllerIdentifier = @"FirstTimeViewController";

@interface FirstTimeWireframe()

@property (nonatomic, strong) FirstTimeViewController *firstTimeViewController;

@end

@implementation FirstTimeWireframe

- (void)presentFirstTimeInterfaceFromWindow:(UIWindow *)window
{
    FirstTimeViewController *firstTimeViewController = [self firstTimeViewControllerFromStoryboard];
    firstTimeViewController.eventHandler = self.firstTimePresenter;
    self.firstTimePresenter.userInterface = firstTimeViewController;
    self.firstTimeViewController = firstTimeViewController;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:firstTimeViewController];
    navigationController.navigationBarHidden = YES;
    
    [UIView transitionWithView:window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{ window.rootViewController = navigationController; }
                    completion:nil];
}

- (void)presentEditInterfaceWithData:(MRegisteredVehicle *)registeredVehicle
                        inNavigation:(UINavigationController *)navController
{
    EditRegisteredVehicleWireframe *wireframe = [EditRegisteredVehicleWireframe new];
    [wireframe presentEditInterfaceWithData:registeredVehicle
                               inNavigation:navController];
}

- (void)presentDeleteVehicleInterfaceFromNavigation:(UINavigationController *)nav
                             withFirstTimePresenter:(FirstTimePresenter *)presenter
                                        withVehicle:(MRegisteredVehicle *)vehicle {
    DeleteVehicleWireframe *wireframe = [DeleteVehicleWireframe new];
    [wireframe presentDeleteVehicleInterfaceFromNavigation:nav
                                      withProfilePresenter:presenter
                                               withVehicle:vehicle];
}

- (void)presentTabBarWireframe
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [self.tabBarWireframe presentTabbarInterfaceFromWindow:appDelegate.window];
    
}

- (FirstTimeViewController *)firstTimeViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    FirstTimeViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:FirstTimeViewControllerIdentifier];
    
    return viewController;
}


- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}


@end
