//
//  VehicleDetailsViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/30/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "VehicleDetailsViewInterface.h"
#import "VehicleDetailsModuleInterface.h"

@protocol VehicleDetailsModuleInterface;

@interface VehicleDetailsViewController : BaseViewController <VehicleDetailsViewInterface>
@property (nonatomic, strong) id<VehicleDetailsModuleInterface> eventHandler;
@end
