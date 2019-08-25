//
//  ServiceConfirmationWireframe.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MServiceRequest;

@interface ServiceConfirmationWireframe : NSObject
- (void)pushConfirmationInterfaceToController:(UINavigationController *)navigationController
                                  withRequest:(MServiceRequest *)request;
@end
