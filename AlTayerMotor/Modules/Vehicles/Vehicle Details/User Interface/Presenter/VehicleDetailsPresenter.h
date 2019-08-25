//
//  VehicleDetailsPresenter.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/30/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VehicleDetailsModuleInterface.h"
#import "VehicleDetailsViewInterface.h"
#import "VehicleDetailsInteractorIO.h"

@class VehicleDetailsWireframe;

@interface VehicleDetailsPresenter : NSObject<VehicleDetailsModuleInterface, VehicleDetailsInteractorOutput>

@property (nonatomic, strong) id<VehicleDetailsInteractorInput> interactor;
@property (nonatomic, strong) VehicleDetailsWireframe *wireframe;
@property (nonatomic, strong) UIViewController<VehicleDetailsViewInterface> *userInterface;

@end
