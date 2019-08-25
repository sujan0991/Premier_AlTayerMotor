//
//  ServiceConfirmationViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "ServiceConfirmationModuleInterface.h"
#import "ServiceConfirmationViewInterface.h"
@class MServiceRequest;


@interface ServiceConfirmationViewController : BaseViewController<ServiceConfirmationViewInterface>

@property (nonatomic, strong) id<ServiceConfirmationModuleInterface> eventHandler;
@property (strong, nonatomic) MServiceRequest *serviceRequest;

@end
