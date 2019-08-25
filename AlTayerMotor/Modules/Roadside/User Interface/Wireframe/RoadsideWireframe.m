//
//  RoadsideWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "RoadsideWireframe.h"
#import "RoadsideViewController.h"
#import "RoadsidePresenter.h"
#import "RoadsideInteractor.h"
#import "RoadsideDataManager.h"
#import "CoreDataStore.h"

static NSString *RoadsideViewControllerIdentifier = @"RoadsideViewController";

@implementation RoadsideWireframe

- (void)presentRoadsideInterfaceFromViewController:(UINavigationController *)navigationController
{
    RoadsideViewController *viewController = [self RoadsideViewControllerFromStoryboard];
    RoadsideDataManager *dataManager = [RoadsideDataManager new];
    RoadsidePresenter *presenter = [RoadsidePresenter new];
    RoadsideInteractor *interactor = [[RoadsideInteractor alloc] initWithDataManager:dataManager];
    viewController.eventHandler = presenter;
    presenter.userInterface = viewController;
    presenter.interactor = interactor;
    presenter.wireframe = self;
    interactor.output = presenter;
    dataManager.dataStore = [CoreDataStore sharedStore];
    
    [navigationController pushViewController:viewController
                                    animated:YES];
}

- (RoadsideViewController *)RoadsideViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    RoadsideViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:RoadsideViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end

