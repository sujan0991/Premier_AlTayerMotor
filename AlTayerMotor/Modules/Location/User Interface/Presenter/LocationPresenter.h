//
//  LocationPresenter.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#import "LocationModuleInterface.h"
#import "LocationViewInterface.h"
#import "LocationInteractorIO.h"

@class LocationWireframe;

@interface LocationPresenter : NSObject<LocationModuleInterface, LocationInteractorOutput>

@property (nonatomic, strong) LocationWireframe *locationWireframe;
@property (nonatomic, strong) BaseViewController<LocationViewInterface> *userInterface;
@property (nonatomic, strong) id<LocationInteractorInput> interactor;

@end
