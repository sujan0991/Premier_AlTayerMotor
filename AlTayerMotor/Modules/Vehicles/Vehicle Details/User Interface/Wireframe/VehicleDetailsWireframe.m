//
//  VehicleDetailsWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/30/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VehicleDetailsWireframe.h"
#import "VehicleDetailsViewController.h"
#import "VehicleDetailsViewController.h"
#import "VehicleDetailsInteractor.h"
#import "VehicleDetailsPresenter.h"
#import "VehicleDetailsDataManager.h"
#import "CoreDataStore.h"
#import "EnquiryWireframe.h"

static NSString *VehicleDetailsViewControllerIdentifier = @"VehicleDetailsViewController";

@implementation VehicleDetailsWireframe

- (void)presentDetailsInterfaceWithData:(MVehicle *)vehicle
                           inNavigation:(UINavigationController *)navigationController
{
    VehicleDetailsViewController *viewController = [self detailsViewControllerFromStoryboard];
    VehicleDetailsDataManager *dataManager = [VehicleDetailsDataManager new];
    VehicleDetailsPresenter *presenter = [VehicleDetailsPresenter new];
    VehicleDetailsInteractor *interactor = [[VehicleDetailsInteractor alloc] initWithDataManager:dataManager];
    viewController.eventHandler = presenter;
    presenter.userInterface = viewController;
    presenter.interactor = interactor;
    presenter.wireframe = self;
    interactor.output = presenter;
    dataManager.dataStore = [CoreDataStore sharedStore];
    [viewController setVehicle:vehicle];
    
    [navigationController pushViewController:viewController
                                    animated:YES];
}

- (void)presentEnquiryInterfaceWithData:(MPreownedBrand *)brand
                              withModel:(NSInteger)modelId
                           inNavigation:(UINavigationController *)navigationController
{
    EnquiryWireframe *wireframe = [EnquiryWireframe new];
    [wireframe presentEnquiryInterfaceWithData:brand
                                     withModel:modelId
                                  inNavigation:navigationController];
}

- (VehicleDetailsViewController *)detailsViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self detailsStoryboard];
    VehicleDetailsViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:VehicleDetailsViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)detailsStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Vehicles"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}


@end
