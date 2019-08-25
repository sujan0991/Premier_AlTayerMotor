//
//  LoadingWireframe.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/14/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LoadingWireframe.h"
#import "RootWireframe.h"
#import "FirstTimeWireframe.h"
#import "TabBarWireframe.h"
#import "LoadingPresenter.h"
#import "LoadingViewController.h"
#import "AppDelegate.h"

static NSString *LoadingViewControllerIdentifier = @"LoadingViewController";

@interface LoadingWireframe()

@property (nonatomic, strong) LoadingViewController *loadingViewController;

@end


@implementation LoadingWireframe

- (void)presentListInterfaceFromWindow:(UIWindow *)window
{
    LoadingViewController *loadingViewController = [self loadingViewControllerFromStoryboard];
    loadingViewController.eventHandler = self.loadingPresenter;
    self.loadingPresenter.userInterface = loadingViewController;
    self.loadingViewController = loadingViewController;
    
    [self.rootWireframe showRootViewController:loadingViewController
                                      inWindow:window];
}

- (void)presentFirstTimeWireframe
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [self.firstTimeWireframe presentFirstTimeInterfaceFromWindow:appDelegate.window];
}

- (void)presentTabBarInteface
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [self.tabBarWireframe presentTabbarInterfaceFromWindow:appDelegate.window];
}

- (LoadingViewController *)loadingViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    LoadingViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:LoadingViewControllerIdentifier];
    
    return viewController;
}


- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
