//
//  ATMNetwork.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/9/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ATMNetwork.h"
#import "MResponse.h"

@implementation ATMNetwork

- (id)payload:(id)dict
{
    return dict ? dict[@"payload"] : nil;
}

- (MResponse *)responseWithoutPayload:(NSDictionary *)responseDict
{
    MResponse *response = [[MResponse alloc] initWithDict:responseDict];
    return response;
}

- (BOOL)isDictionary:(id)dict
{
    return dict && ![dict isEqual:[NSNull null]] && [dict isKindOfClass:[NSDictionary class]];
}

- (BOOL)isArray:(id)array
{
    return array && ![array isEqual:[NSNull null]] && [array isKindOfClass:[NSArray class]];
}

@end
