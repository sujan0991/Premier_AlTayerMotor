//
//  LocationViewController.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "LocationViewInterface.h"
#import "LocationModuleInterface.h"

@class LocationModuleInterface;

@interface LocationViewController : BaseViewController<LocationViewInterface>

@property (nonatomic, strong) id<LocationModuleInterface> eventHandler;

@end
