//
//  ATMNetwork.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/9/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MResponse;

@interface ATMNetwork : NSObject
- (id)payload:(id)dict;
- (MResponse *)responseWithoutPayload:(NSDictionary *)dict;
- (BOOL)isDictionary:(id)dict;
- (BOOL)isArray:(id)array;

@end
