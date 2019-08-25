//
//  LoadingPresenter.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/14/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoadingWireframe.h"
#import "LoadingModuleInterface.h"
#import "LoadingInteractorIO.h"

@protocol LoadingViewInterface;

@interface LoadingPresenter : NSObject<LoadingModuleInterface, LoadingInteractorOutput>

@property (nonatomic, strong) id<LoadingInteractorInput>    loadingInteractor;
@property (nonatomic, strong) LoadingWireframe *loadingWireframe;
@property (nonatomic, weak) UIViewController<LoadingViewInterface> *userInterface;

@end
