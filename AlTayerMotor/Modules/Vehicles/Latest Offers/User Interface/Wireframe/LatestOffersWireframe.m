//
//  LatestOffersWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LatestOffersWireframe.h"
#import "LatestOffersViewController.h"
#import "LatestOffersPresenter.h"
#import "LatestOffersDataManager.h"
#import "LatestOffersNetwork.h"
#import "CoreDataStore.h"
#import "LatestOffersInteractor.h"
#import "TabBarManager.h"
#import "TabBarWireframe.h"
#import "BrandsWireframe.h"
#import "PeekOffersWireframe.h"
#import "ATMNavigationController.h"

static NSString *LatestOffersViewControllerIdentifier = @"LatestOffersViewController";

@implementation LatestOffersWireframe

- (void)initLatestOffersViewController
{
    LatestOffersPresenter *presenter = [LatestOffersPresenter new];
    LatestOffersNetwork *network = [LatestOffersNetwork new];
    LatestOffersInteractor *interactor = [[LatestOffersInteractor alloc] initWithNetwork:network];
    LatestOffersViewController *latestOffersVC = [self latestOffersViewControllerFromStoryboard];
    
    network.apiNetworkInterface= interactor;
    latestOffersVC.eventHandler = presenter;
    presenter.wireframe = self;
    presenter.interactor = interactor;
    presenter.userInterface = latestOffersVC;
    interactor.output = presenter;
    
    ATMNavigationController *nc = [[ATMNavigationController alloc] initWithRootViewController:latestOffersVC];
    
    UIImage *musicImage = [UIImage imageNamed:@"tabbar_vehicle"];
    UIImage *musicImageSel = [UIImage imageNamed:@"tabbar_vehicle_selected"];
    musicImage = [musicImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel = [musicImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nc.tabBarItem = [[UITabBarItem alloc] initWithTitle:LOCALIZED(@"TAB PRE-OWNED") image:musicImage selectedImage:musicImageSel];
    
    [[[TabBarManager sharedManager] subViewControllers] addObject:nc];
}

- (void)presentBrandsInterfaceInNavigation:(UINavigationController *)navController
{
    BrandsWireframe *wireframe = [BrandsWireframe new];
    [wireframe presentBrandsInterfaceInNavigation:navController];
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

- (LatestOffersViewController *)latestOffersViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    LatestOffersViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:LatestOffersViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Vehicles"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}


@end
