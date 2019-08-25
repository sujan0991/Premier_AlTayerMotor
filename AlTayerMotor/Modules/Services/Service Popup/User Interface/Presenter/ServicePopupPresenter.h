//
//  ServicePopupPresenter.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServicePopupModuleInterface.h"
#import "ServicePopupModuleDelegateInterface.h"

@class ServicePopupWireframe;

@interface ServicePopupPresenter : NSObject <ServicePopupModuleInterface>

@property (nonatomic, strong) ServicePopupWireframe *wireframe;
@property (nonatomic, weak) id<ServicePopupModuleDelegate> delegate;

@end
