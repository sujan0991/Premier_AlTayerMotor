//
//  BookingTestWireframe.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BookingTestWireframe.h"
#import "BookingConfirmationWireframe.h"
#import "BookingTestViewController.h"
#import "TabBarManager.h"
#import "BookingTestPresenter.h"
#import "BookingTestDataManager.h"
#import "BookingTestNetwork.h"
#import "BookingTestInteractor.h"
#import "CoreDataStore.h"
#import "ATMNavigationController.h"


static NSString *BookingTestViewControllerIdentifier = @"BookingTestViewController";

@implementation BookingTestWireframe

- (void)initBookingTestViewController
{
    BookingConfirmationWireframe *confirmationWireframe = [BookingConfirmationWireframe new];
    BookingTestDataManager *dataManager = [BookingTestDataManager new];
    BookingTestNetwork *network = [BookingTestNetwork new];
    BookingTestInteractor *interactor = [[BookingTestInteractor alloc] initWithDataManager:dataManager
                                                                                andNetwork:network];
    BookingTestPresenter *bookingTestPresenter = [BookingTestPresenter new];
    BookingTestViewController *bookingTestVC = [self bookingTestViewControllerFromStoryboard];
    bookingTestVC.eventHandler = bookingTestPresenter;
    bookingTestPresenter.bookingTestWireframe = self;
    bookingTestPresenter.userInterface = bookingTestVC;
    bookingTestPresenter.interactor = interactor;
    bookingTestPresenter.bookingConfirmationWireframe = confirmationWireframe;
    interactor.output = bookingTestPresenter;
    dataManager.dataStore = [CoreDataStore sharedStore];
    network.apiNetworkInterface = interactor;
    
    ATMNavigationController *nc = [[ATMNavigationController alloc] initWithRootViewController:bookingTestVC];
    
    UIImage *musicImage = [UIImage imageNamed:@"tabbar_wheel"];
    UIImage *musicImageSel = [UIImage imageNamed:@"tabbar_wheel_selected"];
    musicImage = [musicImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel = [musicImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nc.tabBarItem = [[UITabBarItem alloc] initWithTitle:LOCALIZED(@"TAB TEST DRIVE")
                                                  image:musicImage
                                          selectedImage:musicImageSel];
    
    [[[TabBarManager sharedManager] subViewControllers] addObject:nc];
}

- (BookingTestViewController *)bookingTestViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    BookingTestViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:BookingTestViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BookingTest"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
