//
//  FirstTimePresenter.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/15/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "FirstTimeModuleInterface.h"
#import "BaseViewController.h"
#import "FirstTimeWireframe.h"
#import "FirstTimeInteractorIO.h"
#import "DeleteVehicleModuleDelegate.h"

@class TabBarWireframe;
@protocol FirstTimeViewInterface;

@interface FirstTimePresenter : NSObject<FirstTimeModuleInterface, FirstTimeInteractorOutput, DeleteVehicleModuleDelegate>

@property (nonatomic, strong) id<FirstTimeInteractorInput> firstTimeInteractor;
@property (nonatomic, strong) FirstTimeWireframe *firstTimeWireframe;
@property (nonatomic, strong) BaseViewController<FirstTimeViewInterface> *userInterface;

@end
