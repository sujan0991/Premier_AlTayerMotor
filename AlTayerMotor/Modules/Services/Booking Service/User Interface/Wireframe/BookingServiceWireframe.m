//
//  BookingServiceWireframe.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BookingServiceWireframe.h"
#import "BookingServiceInteractor.h"
#import "CoreDataStore.h"
#import "BookingServiceDataManager.h"
#import "BookingServiceNetwork.h"
#import "BookingServicePresenter.h"
#import "BookingServiceViewController.h"
#import "ServicePopupWireframe.h"
#import "ServiceConfirmationWireframe.h"

static NSString *BookingServiceViewControllerIdentifier = @"BookingServiceViewController";

@interface BookingServiceWireframe()
@property (nonatomic, strong) BookingServiceViewController *bookingServiceViewController;
@end

@implementation BookingServiceWireframe

- (void)pushBookingServiceToViewController:(UINavigationController *)navigationController
                     withRegisteredVehicle:(MRegisteredVehicle *)vehicle;
{
    BookingServiceViewController *bookServiceVC = [self bookingTestViewControllerFromStoryboard];
    BookingServicePresenter *presenter = [BookingServicePresenter new];
    BookingServiceDataManager *dataManager = [BookingServiceDataManager new];
    BookingServiceNetwork *network = [BookingServiceNetwork new];
    BookingServiceInteractor *interator = [[BookingServiceInteractor alloc]
                                           initWithDataManager:dataManager
                                           andNetwork:network];
    
    self.bookingServiceViewController = bookServiceVC;
    self.servicePopupWireframe = [ServicePopupWireframe new];
    self.confirmationWireframe = [ServiceConfirmationWireframe new];
    bookServiceVC.registeredVehicle = vehicle;
    bookServiceVC.eventHandler = presenter;
    presenter.userInterface = bookServiceVC;
    presenter.bookingServiceWireframe = self;
    presenter.bookingServiceInteractor =interator;
    dataManager.dataStore = [CoreDataStore sharedStore];
    network.apiNetworkInterface = interator;
    interator.output = presenter;
    
    [navigationController pushViewController:bookServiceVC animated:YES];
}

- (BookingServiceViewController *)bookingTestViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    BookingServiceViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:BookingServiceViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Services"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

- (void)presentServicePopupInterfaceWithPresenter:(BookingServicePresenter *)presenter
{
    [self.servicePopupWireframe presentAddInterfaceFromViewController:self.bookingServiceViewController
                                          withBookingServicePresenter:presenter];
}

- (void)pushConfirmationInterfaceToController:(UINavigationController *)navigationController
                                  withRequest:(MServiceRequest *)request
{
    [self.confirmationWireframe pushConfirmationInterfaceToController:navigationController
                                                          withRequest:request];
}

@end
