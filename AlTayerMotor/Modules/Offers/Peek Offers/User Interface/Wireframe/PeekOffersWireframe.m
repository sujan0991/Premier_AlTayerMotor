//
//  PeekOffersWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "PeekOffersWireframe.h"
#import "PeekOffersViewController.h"
#import "PeekOffersInteractor.h"
#import "PeekOffersPresenter.h"
#import "PeekOffersDataManager.h"
#import "CoreDataStore.h"

static NSString *PeekOffersViewControllerIdentifier = @"PeekOffersViewController";

@implementation PeekOffersWireframe
- (void)presentPeekOffersInterfaceWithData:(NSArray *)offers
                                   atIndex:(NSInteger)index
                            inInNavigation:(UINavigationController *)navigationController
{
    PeekOffersViewController *viewController = [self peekOffersViewControllerFromStoryboard];
    PeekOffersDataManager *dataManager = [PeekOffersDataManager new];
    PeekOffersPresenter *presenter = [PeekOffersPresenter new];
    PeekOffersInteractor *interactor = [[PeekOffersInteractor alloc] initWithDataManager:dataManager];
    viewController.eventHandler = presenter;
    [viewController setOffersData:offers withDefaultIndex:index];
    presenter.userInterface = viewController;
    presenter.interactor = interactor;
    presenter.wireframe = self;
    interactor.output = presenter;
    dataManager.dataStore = [CoreDataStore sharedStore];
    
    [navigationController.tabBarController presentViewController:viewController
                                                        animated:YES
                                                      completion:nil];
}

- (PeekOffersViewController *)peekOffersViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self vehiclesStoryboard];
    PeekOffersViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:PeekOffersViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)vehiclesStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Offers"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
