//
//  EditRegisteredVehicleWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/4/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import "EditRegisteredVehicleWireframe.h"
#import "EditRegisteredVehicleWireframe.h"
#import "EditRegisteredVehicleViewController.h"
#import "EditRegisteredVehiclePresenter.h"
#import "EditRegisteredVehicleDataManager.h"
#import "EditRegisteredVehicleInteractor.h"
#import "CoreDataStore.h"

static NSString *EditRegisteredVehicleViewControllerIdentifier = @"EditRegisteredVehicleViewController";

@implementation EditRegisteredVehicleWireframe

- (void)presentEditInterfaceWithData:(MRegisteredVehicle *)registeredVehicle
                        inNavigation:(UINavigationController *)navController
{
    EditRegisteredVehiclePresenter *presenter = [EditRegisteredVehiclePresenter new];
    EditRegisteredVehicleDataManager *dataManager = [EditRegisteredVehicleDataManager new];
    EditRegisteredVehicleInteractor *interactor = [[EditRegisteredVehicleInteractor alloc] initWithDataManager:dataManager];
    EditRegisteredVehicleViewController *viewController = [self EditRegisteredVehicleViewControllerFromStoryboard];
    
    presenter.wireframe = self;
    presenter.interactor = interactor;
    presenter.userInterface = viewController;
    interactor.output = presenter;
    dataManager.dataStore = [CoreDataStore new];
    viewController.eventHandler = presenter;
    [viewController setRegisteredVehicle:registeredVehicle];
    [navController pushViewController:viewController
                             animated:YES];
}

- (EditRegisteredVehicleViewController *)EditRegisteredVehicleViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    EditRegisteredVehicleViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:EditRegisteredVehicleViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Vehicles"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
