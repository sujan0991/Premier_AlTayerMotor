//
//  EnquiryConfirmationPresenter.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "EnquiryConfirmationModuleInterface.h"
#import "EnquiryConfirmationViewInterface.h"

@class EnquiryConfirmationWireframe;

@interface EnquiryConfirmationPresenter : NSObject<EnquiryConfirmationModuleInterface>
@property (nonatomic, strong) EnquiryConfirmationWireframe *wireframe;
@property (nonatomic, strong) BaseViewController<EnquiryConfirmationViewInterface> *userInterface;
@end
