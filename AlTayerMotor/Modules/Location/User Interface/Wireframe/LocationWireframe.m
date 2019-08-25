//
//  LocationWireframe.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LocationWireframe.h"
#import "LocationInteractor.h"
#import "LocationDataManager.h"
#import "CoreDataStore.h"
#import "LocationPresenter.h"
#import "LocationViewController.h"
#import "TabBarManager.h"
#import "ATMNavigationController.h"

static NSString *LocationViewControllerIdentifier = @"LocationViewController";

@implementation LocationWireframe

- (void)initLocationViewController
{
    LocationDataManager *dataManager = [LocationDataManager new];
    dataManager.dataStore = [CoreDataStore sharedStore];
    
    LocationInteractor *interactor = [[LocationInteractor alloc] initWithDataManager:dataManager];
    
    LocationPresenter *locationPresenter = [LocationPresenter new];
    locationPresenter.locationWireframe = self;
    locationPresenter.interactor = interactor;
    interactor.output = locationPresenter;
    
    LocationViewController *locationVC = [self locationViewControllerFromStoryboard];
    locationVC.eventHandler = locationPresenter;
    
    locationPresenter.userInterface = locationVC;
    
    ATMNavigationController *nc = [[ATMNavigationController alloc] initWithRootViewController:locationVC];

    UIImage *musicImage = [UIImage imageNamed:@"tabbar_location"];
    UIImage *musicImageSel = [UIImage imageNamed:@"tabbar_location_selected"];
    musicImage = [musicImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel = [musicImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nc.tabBarItem = [[UITabBarItem alloc] initWithTitle:LOCALIZED(@"TAB LOCATIONS")
                                                  image:musicImage
                                          selectedImage:musicImageSel];
    
    [[[TabBarManager sharedManager] subViewControllers] addObject:nc];
}

- (LocationViewController *)locationViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    LocationViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:LocationViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Location"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
