//
//  ServiceConfirmationPresenter.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/4/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "ServiceConfirmationModuleInterface.h"

@class ServiceConfirmationWireframe;
@protocol ServiceConfirmationViewInterface;

@interface ServiceConfirmationPresenter : NSObject <ServiceConfirmationModuleInterface>

@property (nonatomic, strong) ServiceConfirmationWireframe* wireframe;
@property (nonatomic, strong) BaseViewController<ServiceConfirmationViewInterface> *userInterface;

@end
