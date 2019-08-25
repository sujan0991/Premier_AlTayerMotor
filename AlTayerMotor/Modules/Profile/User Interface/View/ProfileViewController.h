//
//  ProfileViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "ProfileViewInterface.h"

@protocol ProfileModuleInterface;

@interface ProfileViewController : BaseViewController <ProfileViewInterface>

@property (nonatomic, strong) id<ProfileModuleInterface> eventHandler;

@end
