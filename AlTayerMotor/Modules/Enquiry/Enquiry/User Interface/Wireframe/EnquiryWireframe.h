//
//  EnquiryWireframe.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/25/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MPreownedBrand;

@interface EnquiryWireframe : NSObject
- (void)presentEnquiryInterfaceFromViewController:(UINavigationController *)navigationController;
- (void)presentEnquiryInterfaceWithData:(MPreownedBrand *)brand
                              withModel:(NSInteger)modelId
                           inNavigation:(UINavigationController *)navigationController;
- (void)presentConfirmationIntefaceInNavigationController:(UINavigationController *)navigationController;
@end
