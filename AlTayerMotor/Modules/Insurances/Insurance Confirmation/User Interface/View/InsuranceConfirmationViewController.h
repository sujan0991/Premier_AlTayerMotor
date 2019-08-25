//
//  InsuranceConfirmationViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/16/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "InsuranceConfirmationModuleInterface.h"
#import "InsuranceConfirmationViewInterface.h"

@interface InsuranceConfirmationViewController : BaseViewController <InsuranceConfirmationViewInterface>

@property (nonatomic, strong) id<InsuranceConfirmationModuleInterface> eventHandler;

@end