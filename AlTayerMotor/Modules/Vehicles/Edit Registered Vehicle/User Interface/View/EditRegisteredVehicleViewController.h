//
//  EditRegisteredVehicleViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/4/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "EditRegisteredVehicleViewInterface.h"

@protocol EditRegisteredVehicleModuleInterface;

@interface EditRegisteredVehicleViewController : BaseViewController <EditRegisteredVehicleViewInterface>

@property (nonatomic, strong) id<EditRegisteredVehicleModuleInterface> eventHandler;

@end
