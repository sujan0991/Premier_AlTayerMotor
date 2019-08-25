//
//  NewCarsWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "NewCarsWireframe.h"
#import "NewCarsViewController.h"
#import "NewCarsPresenter.h"
#import "NewCarsInteractor.h"
#import "NewCarsDataManager.h"
#import "CoreDataStore.h"

static NSString *NewCarsViewControllerIdentifier = @"NewCarsViewController";

@implementation NewCarsWireframe

- (void)presentNewCarsInterfaceFromViewController:(UINavigationController *)navigationController
{
    NewCarsViewController *viewController = [self newCarsViewControllerFromStoryboard];
    NewCarsDataManager *dataManager = [NewCarsDataManager new];
    NewCarsPresenter *presenter = [NewCarsPresenter new];
    NewCarsInteractor *interactor = [[NewCarsInteractor alloc] initWithDataManager:dataManager];
    viewController.eventHandler = presenter;
    presenter.userInterface = viewController;
    presenter.interactor = interactor;
    presenter.wireframe = self;
    interactor.output = presenter;
    dataManager.dataStore = [CoreDataStore sharedStore];
    
    [navigationController pushViewController:viewController
                                    animated:YES];
}

- (NewCarsViewController *)newCarsViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    NewCarsViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:NewCarsViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
