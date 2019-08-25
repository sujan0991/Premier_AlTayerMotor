//
//  ServicesWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/5/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ServicesWireframe.h"
#import "BookingServiceWireframe.h"
#import "ServicesInteractor.h"
#import "ServicesPresenter.h"
#import "ServicesDataManager.h"
#import "ServicesViewController.h"
#import "TabBarManager.h"
#import "CoreDataStore.h"
#import "DeleteVehicleWireframe.h"
#import "ATMNavigationController.h"

static NSString *ServicesViewControllerIdentifier = @"ServicesViewController";

@implementation ServicesWireframe

- (void)initServicesViewController
{
    ServicesDataManager *serviceDataManager = [ServicesDataManager new];
    ServicesInteractor *serviceInteractor = [[ServicesInteractor alloc] initWithDataManager:serviceDataManager];
    ServicesPresenter *servicesPresenter = [ServicesPresenter new];
    ServicesViewController *servicesVC = [self bookingTestViewControllerFromStoryboard];
    BookingServiceWireframe *bookingServiceWireframe = [BookingServiceWireframe new];
    
    servicesVC.eventHandler = servicesPresenter;
    servicesPresenter.userInterface = servicesVC;
    servicesPresenter.servicesWireframe = self;
    servicesPresenter.servicesInteractor = serviceInteractor;
    servicesPresenter.bookingServiceWireframe = bookingServiceWireframe;
    serviceInteractor.output = servicesPresenter;
    serviceDataManager.dataStore = [CoreDataStore sharedStore];
    
    ATMNavigationController *nc = [[ATMNavigationController alloc] initWithRootViewController:servicesVC];
    
    UIImage *musicImage = [UIImage imageNamed:@"tabbar_service"];
    UIImage *musicImageSel = [UIImage imageNamed:@"tabbar_service_selected"];
    musicImage = [musicImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel = [musicImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nc.tabBarItem = [[UITabBarItem alloc] initWithTitle:LOCALIZED(@"TAB SERVICES")
                                                  image:musicImage
                                          selectedImage:musicImageSel];
    
    [[[TabBarManager sharedManager] subViewControllers] addObject:nc];
}

- (void)presentDeleteVehicleInterfaceFromNavigation:(UINavigationController *)nav
                              withServicesPresenter:(ServicesPresenter *)presenter
                                        withVehicle:(MRegisteredVehicle *)vehicle
{
    DeleteVehicleWireframe *wireframe = [DeleteVehicleWireframe new];
    [wireframe presentDeleteVehicleInterfaceFromNavigation:nav
                                     withServicesPresenter:presenter
                                               withVehicle:vehicle];
}

- (ServicesViewController *)bookingTestViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    ServicesViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:ServicesViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Services"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
