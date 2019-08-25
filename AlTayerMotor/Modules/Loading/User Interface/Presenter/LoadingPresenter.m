//
//  LoadingPresenter.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/14/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LoadingPresenter.h"
#import "LoadingViewInterface.h"
#import "LocalDataManager.h"

@implementation LoadingPresenter

#pragma mark - Loading Module Interface
- (void)showNextInterface
{
    BOOL showFirstTime = [[LocalDataManager sharedManager] shownFirstTime];
    if (showFirstTime) {
        [self showMainInterface];
    } else {
        [self showFirstTimeInterface];
    }
    
}

- (void)showFirstTimeInterface
{
    [self.loadingWireframe presentFirstTimeWireframe];
}

- (void)showMainInterface
{
    [self.loadingWireframe presentTabBarInteface];
}

- (void)generateToken
{
    [self.userInterface startLoadingIndicator];
    [self.loadingInteractor startSyncing];
}


#pragma mark - Data Interactor Output
- (void)didCompleteSyncing
{
    [self.userInterface doExitAnimation];
}


@end