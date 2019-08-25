//
//  OffersWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "OffersWireframe.h"
#import "OffersViewController.h"
#import "OffersPresenter.h"
#import "OffersInteractor.h"
#import "OffersDataManager.h"
#import "OffersNetwork.h"
#import "CoreDataStore.h"
#import "OffersFilterWireframe.h"
#import "PeekOffersWireframe.h"

static NSString *OffersViewControllerIdentifier = @"OffersViewController";

@implementation OffersWireframe

- (void)presentOffersInterfaceInNavigation:(UINavigationController *)navControlelr
{
    OffersViewController *viewController = [self offersViewControllerFromStoryboard];
    OffersDataManager *dataManager = [OffersDataManager new];
    OffersPresenter *presenter = [OffersPresenter new];
    OffersNetwork *network = [OffersNetwork new];
    OffersInteractor *interactor = [[OffersInteractor alloc] initWithDataManager:dataManager andNetwork:network];
    network.apiNetworkInterface = interactor;
    viewController.eventHandler = presenter;
    presenter.userInterface = viewController;
    presenter.interactor = interactor;
    presenter.wireframe = self;
    interactor.output = presenter;
    dataManager.dataStore = [CoreDataStore sharedStore];
    
    [navControlelr pushViewController:viewController
                                    animated:YES];
}

- (void)presentOffersFilterWithData:(OffersFilterDisplayData *)data
                       inNavigation:(UINavigationController *)navController
{
    OffersFilterWireframe *wireframe = [OffersFilterWireframe new];
    [wireframe presentFilterInterfaceInNavigation:navController
                                withData:data];
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

- (OffersViewController *)offersViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    OffersViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:OffersViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Offers"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}
@end
