//
//  VehicleDetailsModuleInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/30/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MPreownedBrand;

@protocol VehicleDetailsModuleInterface <NSObject>
- (void)presentSendEnquiryInterfaceWittData:(MPreownedBrand *)brand andModel:(NSInteger)modelId;
@end
