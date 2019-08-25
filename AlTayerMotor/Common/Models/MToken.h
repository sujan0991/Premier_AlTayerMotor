//
//  MToken.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/2/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@interface MToken : MBase

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, assign) NSInteger expiresIn;
@property (nonatomic, strong) NSString *bearer;
@property (nonatomic, assign) NSTimeInterval logedInTime;

- (instancetype)initWithDict:(NSDictionary *)dict;
- (BOOL)needUpdate;
@end