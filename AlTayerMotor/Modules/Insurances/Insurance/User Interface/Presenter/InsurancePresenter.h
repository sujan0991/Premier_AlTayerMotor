//
//  InsurancePresenter.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "InsuranceModuleInterface.h"
#import "InsuranceViewInterface.h"
#import "InsuranceInteractorIO.h"

@class InsuranceWireframe;
@class InsuranceConfirmationWireframe;

@interface InsurancePresenter : NSObject <InsuranceModuleInterface, InsuranceInteractorOutput>

@property (nonatomic, strong) id<InsuranceInteractorInput> interactor;
@property (nonatomic, strong) InsuranceWireframe *insuranceWireframe;
@property (nonatomic, strong) InsuranceConfirmationWireframe *confirmationWireframe;
@property (nonatomic, strong) BaseViewController<InsuranceViewInterface> *userInterface;

@end