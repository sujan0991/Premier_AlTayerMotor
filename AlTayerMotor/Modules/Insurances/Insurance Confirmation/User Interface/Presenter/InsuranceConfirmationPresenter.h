//
//  InsuranceConfirmationPresenter.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/16/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "InsuranceConfirmationModuleInterface.h"
#import "InsuranceConfirmationWireframe.h"
#import "InsuranceConfirmationViewInterface.h"

@interface InsuranceConfirmationPresenter : NSObject <InsuranceConfirmationModuleInterface>
@property (nonatomic, strong) InsuranceConfirmationWireframe *wireframe;
@property (nonatomic, strong) BaseViewController<InsuranceConfirmationViewInterface> *userInterface;
@property (nonatomic, weak) InsurancePresenter *insurancePresenter;
@end
