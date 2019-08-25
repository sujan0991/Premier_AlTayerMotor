//
//  AppDependencies.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/14/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "AppDependencies.h"

#import "RootWireframe.h"

#import "LoadingWireframe.h"
#import "LoadingPresenter.h"
#import "LoadingInteractor.h"
#import "LoadingNetwork.h"
#import "LoadingDataManager.h"

#import "FirstTimeWireframe.h"
#import "FirstTimePresenter.h"
#import "FirstTimeInteractor.h"
#import "FirstTimeDataManager.h"

#import "TabBarWireframe.h"
#import "CoreDataStore.h"

@interface AppDependencies ()

@property (nonatomic, strong) LoadingWireframe *loadingWireframe;

@end

@implementation AppDependencies

- (id)init {
    if (self = [super init]) {
        [self configureDependencies];
    }
    return self;
}

- (void)installRootViewControllerIntoWindow:(UIWindow *)window
{
    [self.loadingWireframe presentListInterfaceFromWindow:window];
}

- (void)configureDependencies
{
    RootWireframe *rootWireFrame = [RootWireframe new];

    //Loading Modules Classes
    LoadingWireframe *loadingWireframe = [LoadingWireframe new];
    LoadingPresenter *loadingPresenter = [LoadingPresenter new];
    LoadingNetwork *loadingNetwork = [LoadingNetwork new];
    LoadingDataManager *loadingDataManager = [LoadingDataManager new];
    LoadingInteractor *loadingInteractor = [[LoadingInteractor alloc] initWithNetwork:loadingNetwork
                                                                       andDataManager:loadingDataManager];
    
    //First Time Modules Classes
    FirstTimeWireframe *firstTimeWireFrame = [FirstTimeWireframe new];
    FirstTimePresenter *firstTimePresenter = [FirstTimePresenter new];
    FirstTimeDataManager *firstTimeDataManager = [FirstTimeDataManager new];
    FirstTimeInteractor *firstTimeInteractor = [[FirstTimeInteractor alloc] initWithDataManager:firstTimeDataManager];
    
    //TabBar Modules Classes
    TabBarWireframe *tabBarWireframe = [TabBarWireframe new];
    
    loadingPresenter.loadingWireframe = loadingWireframe;
    loadingWireframe.loadingPresenter = loadingPresenter;
    loadingWireframe.firstTimeWireframe = firstTimeWireFrame;
    loadingWireframe.rootWireframe = rootWireFrame;
    loadingWireframe.tabBarWireframe = tabBarWireframe;
    loadingInteractor.output = loadingPresenter;
    loadingDataManager.dataStore = [CoreDataStore new];
    loadingPresenter.loadingInteractor = loadingInteractor;
    loadingNetwork.apiNetworkInterface = loadingInteractor;
    
    self.loadingWireframe = loadingWireframe;

    firstTimeInteractor.output = firstTimePresenter;
    
    firstTimePresenter.firstTimeWireframe = firstTimeWireFrame;
    firstTimePresenter.firstTimeInteractor = firstTimeInteractor;
    
    firstTimeWireFrame.firstTimePresenter = firstTimePresenter;
    firstTimeWireFrame.tabBarWireframe = tabBarWireframe;
    firstTimeWireFrame.rootWireframe = rootWireFrame;
    firstTimeDataManager.dataStore = [CoreDataStore new];
}


@end
