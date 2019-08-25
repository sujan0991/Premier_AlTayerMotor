//
//  BrandsWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BrandsWireframe.h"
#import "BrandsViewController.h"
#import "BrandsInteractor.h"
#import "BrandsPresenter.h"
#import "BrandsDataManager.h"
#import "CoreDataStore.h"
#import "VehiclesWireframe.h"
#import "ATMNavigationController.h"
#import "TabBarManager.h"

static NSString *BrandsViewControllerIdentifier = @"BrandsViewController";

@implementation BrandsWireframe

- (void)initInsuranceViewController {
    BrandsViewController *viewController = [self brandsViewControllerFromStoryboard];
    BrandsDataManager *dataManager = [BrandsDataManager new];
    BrandsPresenter *presenter = [BrandsPresenter new];
    BrandsInteractor *interactor = [[BrandsInteractor alloc] initWithDataManager:dataManager];
    viewController.eventHandler = presenter;
    presenter.userInterface = viewController;
    presenter.interactor = interactor;
    presenter.wireframe = self;
    interactor.output = presenter;
    dataManager.dataStore = [CoreDataStore sharedStore];
    
    ATMNavigationController *nc = [[ATMNavigationController alloc] initWithRootViewController:viewController];
    UIImage *musicImage = [UIImage imageNamed:@"tabbar_vehicle"];
    UIImage *musicImageSel = [UIImage imageNamed:@"tabbar_vehicle_selected"];
    musicImage = [musicImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel = [musicImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nc.tabBarItem = [[UITabBarItem alloc] initWithTitle:LOCALIZED(@"TAB PRE-OWNED") image:musicImage selectedImage:musicImageSel];
    
    [[[TabBarManager sharedManager] subViewControllers] addObject:nc];
}

- (void)presentBrandsInterfaceInNavigation:(UINavigationController *)navigationController
{
    BrandsViewController *viewController = [self brandsViewControllerFromStoryboard];
    BrandsDataManager *dataManager = [BrandsDataManager new];
    BrandsPresenter *presenter = [BrandsPresenter new];
    BrandsInteractor *interactor = [[BrandsInteractor alloc] initWithDataManager:dataManager];
    viewController.eventHandler = presenter;
    presenter.userInterface = viewController;
    presenter.interactor = interactor;
    presenter.wireframe = self;
    interactor.output = presenter;
    dataManager.dataStore = [CoreDataStore sharedStore];
    
    [navigationController pushViewController:viewController
                                    animated:YES];
}

- (void)presentVehiclesInterfaceWithBrand:(MPreownedBrand *)brand
                             inNavigation:(UINavigationController *)navigationController
{
    VehiclesWireframe *wireframe = [VehiclesWireframe new];
    [wireframe presentVehiclesInterfaceInBrand:brand inNavigation:navigationController];
}

- (BrandsViewController *)brandsViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self vehiclesStoryboard];
    BrandsViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:BrandsViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)vehiclesStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Vehicles"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
