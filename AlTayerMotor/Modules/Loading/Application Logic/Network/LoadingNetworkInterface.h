//
//  LoadingNetworkInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/2/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MToken;
@class MResponse;

typedef NS_ENUM(NSInteger, LoadingApiType) {
    LoadingApiTypeToken,
    LoadingApiTypeBrand,
    LoadingApiTypePreownedBrand,
    LoadingApiTypeCity,
    LoadingApiTypeLocation,
    LoadingApiTypeDrivingExperiences,
    LoadingApiTypeGlobalSettings
};



@protocol LoadingNetworkInterface <NSObject>

-(void)networkError:(NSError *)error inApi:(LoadingApiType)type;
-(void)networkDidLoad:(MResponse*)response fromApi:(LoadingApiType)type;

@end
