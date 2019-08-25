//
//  ProfileInteractor.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileInteractorIO.h"

@class ProfileDataManager;

@interface ProfileInteractor : NSObject <ProfileInteractorInput>

@property (nonatomic, weak) id<ProfileInteractorOutput> output;

- (instancetype)initWithDataManager:(ProfileDataManager *)dataManager;

@end