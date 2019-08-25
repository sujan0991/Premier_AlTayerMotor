//
//  InsuranceWireframe.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "InsuranceWireframe.h"
#import "InsurancePresenter.h"
#import "InsuranceNetwork.h"
#import "InsuranceInteractor.h"
#import "InsuranceDataManager.h"
#import "InsuranceViewController.h"
#import "TabBarManager.h"
#import "CoreDataStore.h"
#import "InsuranceConfirmationWireframe.h"
#import "ATMNavigationController.h"

static NSString *InsuranceViewControllerIdentifier = @"InsuranceViewController";

@implementation InsuranceWireframe

- (void)initInsuranceViewController
{
    InsuranceConfirmationWireframe *confirmationWireframe = [InsuranceConfirmationWireframe new];
    InsurancePresenter *insurancePresenter = [InsurancePresenter new];
    InsuranceViewController *insuranceVC = [self insuranceViewControllerFromStoryboard];
    InsuranceDataManager *dataManager = [InsuranceDataManager new];
    InsuranceNetwork *network = [InsuranceNetwork new];
    InsuranceInteractor *interactor = [[InsuranceInteractor alloc] initWithDataManager:dataManager
                                                                            andNetwork:network];
    
    insuranceVC.eventHandler = insurancePresenter;
    insurancePresenter.insuranceWireframe = self;
    insurancePresenter.userInterface = insuranceVC;
    insurancePresenter.interactor = interactor;
    insurancePresenter.confirmationWireframe = confirmationWireframe;
    interactor.output = insurancePresenter;
    dataManager.dataStore = [CoreDataStore sharedStore];
    network.apiNetworkInterface = interactor;
    
    ATMNavigationController *nc = [[ATMNavigationController alloc] initWithRootViewController:insuranceVC];
    UIImage *musicImage = [UIImage imageNamed:@"tabbar_insurance"];
    UIImage *musicImageSel = [UIImage imageNamed:@"tabbar_insurance_selected"];
    musicImage = [musicImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel = [musicImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nc.tabBarItem = [[UITabBarItem alloc] initWithTitle:LOCALIZED(@"TAB INSURANCE")
                                                  image:musicImage
                                          selectedImage:musicImageSel];
    
    [[[TabBarManager sharedManager] subViewControllers] addObject:nc];
}

- (InsuranceViewController *)insuranceViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    InsuranceViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:InsuranceViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Insurance"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
