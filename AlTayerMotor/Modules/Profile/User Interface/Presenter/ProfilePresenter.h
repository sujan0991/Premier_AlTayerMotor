//
//  ProfilePresenter.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "ProfileModuleInterface.h"
#import "ProfileInteractorIO.h"
#import "DeleteVehicleModuleDelegate.h"

@protocol ProfileViewInterface;
@class ProfileWireframe;

@interface ProfilePresenter : NSObject<ProfileInteractorOutput, ProfileModuleInterface, DeleteVehicleModuleDelegate>

@property (nonatomic, strong) id<ProfileInteractorInput> interactor;
@property (nonatomic, strong) BaseViewController<ProfileViewInterface> *userInterface;
@property (nonatomic, strong) ProfileWireframe *wireframe;

@end