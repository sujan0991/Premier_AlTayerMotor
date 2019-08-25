//
//  VehicleDetailsPresenter.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/30/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VehicleDetailsPresenter.h"
#import "VehicleDetailsWireframe.h"

@implementation VehicleDetailsPresenter

- (void)presentSendEnquiryInterfaceWittData:(MPreownedBrand *)brand andModel:(NSInteger)modelId
{
    [self.wireframe presentEnquiryInterfaceWithData:brand
                                          withModel:modelId
                                       inNavigation:self.userInterface.navigationController];
}

@end
