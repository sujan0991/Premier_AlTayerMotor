//
//  EditRegisteredVehicleInteractor.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/4/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "EditRegisteredVehicleInteractorIO.h"

@class EditRegisteredVehicleDataManager;

@interface EditRegisteredVehicleInteractor : NSObject <EditRegisteredVehicleInteractorInput>

@property (nonatomic, weak) id<EditRegisteredVehicleInteractorOutput> output;

- (instancetype)initWithDataManager:(EditRegisteredVehicleDataManager *)dataManager;

@end
