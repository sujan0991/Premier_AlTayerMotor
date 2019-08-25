//
//  VehiclesPresenter.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "VehiclesModuleInteface.h"
#import "VehiclesViewInterface.h"
#import "VehiclesInteractorIO.h"

@class VehiclesWireframe;

@interface VehiclesPresenter : NSObject<VehiclesModuleInteface, VehiclesInteractorOutput>

@property (nonatomic, strong) id<VehiclesInteractorInput> vehiclesInteractor;
@property (nonatomic, strong) VehiclesWireframe *vehiclesWireframe;
@property (nonatomic, strong) BaseViewController<VehiclesViewInterface> *userInterface;

@end
