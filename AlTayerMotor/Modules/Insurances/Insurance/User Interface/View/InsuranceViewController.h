//
//  InsuranceViewController.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "InsuranceViewInterface.h"
#import "InsuranceModuleInterface.h"

@interface InsuranceViewController : BaseViewController <InsuranceViewInterface>

@property (nonatomic, strong) id<InsuranceModuleInterface> eventHandler;

@end
