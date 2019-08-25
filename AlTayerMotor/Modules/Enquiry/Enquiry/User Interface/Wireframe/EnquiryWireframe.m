//
//  EnquiryWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/25/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "EnquiryWireframe.h"
#import "EnquiryViewController.h"
#import "EnquiryPresenter.h"
#import "EnquiryInteractor.h"
#import "EnquiryDataManager.h"
#import "EnquiryNetwork.h"
#import "CoreDataStore.h"
#import "EnquiryConfirmationWireframe.h"
#import "MPreownedBrand.h"

static NSString *EnquiryViewControllerIdentifier = @"EnquiryViewController";

@implementation EnquiryWireframe

- (void)presentEnquiryInterfaceFromViewController:(UINavigationController *)navigationController
{
    [self presentEnquiryInterfaceWithData:nil
                                withModel: 0
                             inNavigation:navigationController];
}

- (void)presentEnquiryInterfaceWithData:(MPreownedBrand *)brand
                              withModel:(NSInteger)modelId
                           inNavigation:(UINavigationController *)navigationController
{
    EnquiryViewController *viewController = [self EnquiryViewControllerFromStoryboard];
    EnquiryDataManager *dataManager = [EnquiryDataManager new];
    EnquiryNetwork *network = [EnquiryNetwork new];
    EnquiryPresenter *presenter = [EnquiryPresenter new];
    EnquiryInteractor *interactor = [[EnquiryInteractor alloc] initWithDataManager:dataManager
                                                                        andNetwork:network];
    viewController.eventHandler = presenter;
    presenter.userInterface = viewController;
    presenter.interactor = interactor;
    presenter.wireframe = self;
    network.apiNetworkInterface = interactor;
    interactor.output = presenter;
    dataManager.dataStore = [CoreDataStore sharedStore];
    [viewController didSetDefaultBrand:brand.id
                              andModel:modelId];
    
    [navigationController pushViewController:viewController
                                    animated:YES];
    
}

- (void)presentConfirmationIntefaceInNavigationController:(UINavigationController *)navigationController
{
    [[EnquiryConfirmationWireframe new]
     presentInsuranceConfirmationInterfaceInNavigationController:navigationController];
}

- (EnquiryViewController *)EnquiryViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    EnquiryViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:EnquiryViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Enquiry"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
