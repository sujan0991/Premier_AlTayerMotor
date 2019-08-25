//
//  VehiclesFilterWireframe.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VehiclesFilterDisplayData;
@interface VehiclesFilterWireframe : NSObject
- (void)presentFilterInController:(UINavigationController *)nc withData:(VehiclesFilterDisplayData *)data;
@end
