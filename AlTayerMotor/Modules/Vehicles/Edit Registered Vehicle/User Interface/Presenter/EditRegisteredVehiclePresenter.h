//
//  EditRegisteredVehiclePresenter.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/4/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "EditRegisteredVehicleModuleInterface.h"
#import "EditRegisteredVehicleInteractorIO.h"

@protocol EditRegisteredVehicleViewInterface;
@class EditRegisteredVehicleWireframe;

@interface EditRegisteredVehiclePresenter : NSObject <EditRegisteredVehicleInteractorOutput, EditRegisteredVehicleModuleInterface>

@property (nonatomic, strong) id<EditRegisteredVehicleInteractorInput> interactor;
@property (nonatomic, strong) BaseViewController<EditRegisteredVehicleViewInterface> *userInterface;
@property (nonatomic, strong) EditRegisteredVehicleWireframe *wireframe;


@end
