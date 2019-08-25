//
//  ProfileWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ProfileWireframe.h"
#import "ProfileViewController.h"
#import "ProfilePresenter.h"
#import "ProfileInteractor.h"
#import "ProfileDataManager.h"
#import "CoreDataStore.h"
#import "MRegisteredVehicle.h"
#import "EditRegisteredVehicleWireframe.h"
#import "DeleteVehicleWireframe.h"

static NSString *ProfileViewControllerIdentifier = @"ProfileViewController";

@implementation ProfileWireframe

- (void)presentProfileInterfaceFromViewController:(UINavigationController *)navigationController
{
    ProfileViewController *viewController = [self profileViewControllerFromStoryboard];
    ProfileDataManager *dataManager = [ProfileDataManager new];
    ProfilePresenter *presenter = [ProfilePresenter new];
    ProfileInteractor *interactor = [[ProfileInteractor alloc] initWithDataManager:dataManager];
    viewController.eventHandler = presenter;
    presenter.userInterface = viewController;
    presenter.interactor = interactor;
    presenter.wireframe = self;
    interactor.output = presenter;
    dataManager.dataStore = [CoreDataStore sharedStore];
    
    [navigationController pushViewController:viewController
                                    animated:YES];
}

- (void)presentEditInterfaceWithData:(MRegisteredVehicle *)registeredVehicle
                        inNavigation:(UINavigationController *)navController
{
    EditRegisteredVehicleWireframe *wireframe = [EditRegisteredVehicleWireframe new];
    [wireframe presentEditInterfaceWithData:registeredVehicle
                               inNavigation:navController];
}

- (void)presentDeleteVehicleInterfaceFromNavigation:(UINavigationController *)nav
                               withProfilePresenter:(ProfilePresenter *)presenter
                                        withVehicle:(MRegisteredVehicle *)vehicle
{
    DeleteVehicleWireframe *wireframe = [DeleteVehicleWireframe new];
    [wireframe presentDeleteVehicleInterfaceFromNavigation:nav
                                      withProfilePresenter:presenter
                                               withVehicle:vehicle];
}

- (ProfileViewController *)profileViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    ProfileViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:ProfileViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}
@end
