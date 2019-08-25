//
//  VehiclesWireframe.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VehiclesWireframe.h"
#import "TabBarWireframe.h"
#import "VehiclesWireframe.h"
#import "VehiclesViewController.h"
#import "VehiclesPresenter.h"
#import "VehiclesDataManager.h"
#import "VehiclesInteractor.h"
#import "VehiclesNetwork.h"
#import "CoreDataStore.h"
#import "VehicleDetailsWireframe.h"
#import "VehiclesFilterWireframe.h"
#import "PeekOffersWireframe.h"
#import "TabBarManager.h"

static NSString *VehiclesViewControllerIdentifier = @"VehiclesViewController";

@implementation VehiclesWireframe

- (void)presentVehiclesInterfaceInBrand:(MPreownedBrand *)brand
                           inNavigation:(UINavigationController *)navController {
    VehiclesPresenter *presenter = [VehiclesPresenter new];
    VehiclesDataManager *dataManager = [VehiclesDataManager new];
    VehiclesNetwork *network = [VehiclesNetwork new];
    VehiclesInteractor *interactor = [[VehiclesInteractor alloc] initWithDataManager:dataManager andNetwork:network];
    VehiclesViewController *vehiclesVC = [self vehiclesViewControllerFromStoryboard];
    
    presenter.vehiclesWireframe = self;
    presenter.vehiclesInteractor = interactor;
    presenter.userInterface = vehiclesVC;
    interactor.output = presenter;
    dataManager.dataStore = [CoreDataStore new];
    vehiclesVC.eventHandler = presenter;
    vehiclesVC.brand = brand;
    network.apiNetworkInterface = interactor;
    [navController pushViewController:vehiclesVC
                             animated:YES];
}

- (void)presentFilterVehiclesWithData:(VehiclesFilterDisplayData *)data
                         inNavigation:(UINavigationController *)navController
{
    VehiclesFilterWireframe *wireframe = [VehiclesFilterWireframe new];
    [wireframe presentFilterInController:navController
                                withData:data];
}

- (void)presentDetailsInterfaceWithData:(MVehicle *)vehicle
                           inNavigation:(UINavigationController *)navigationController
{
    VehicleDetailsWireframe *wireframe = [VehicleDetailsWireframe new];
    [wireframe presentDetailsInterfaceWithData:vehicle
                                  inNavigation:navigationController];
}

- (void)presentPeekOffersInterfaceWithData:(NSArray*)offers
                           withViewedIndex:(NSInteger)index
                              inNavigation:(UINavigationController *)navController
{
    PeekOffersWireframe *wireframe = [PeekOffersWireframe new];
    [wireframe presentPeekOffersInterfaceWithData:offers
                                          atIndex:index
                                   inInNavigation:navController];
}

- (VehiclesViewController *)vehiclesViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    VehiclesViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:VehiclesViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Vehicles"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}


@end
