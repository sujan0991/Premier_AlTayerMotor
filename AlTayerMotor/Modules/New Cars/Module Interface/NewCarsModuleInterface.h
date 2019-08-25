//
//  NewCarsModuleInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBrand;

@protocol NewCarsModuleInterface <NSObject>
-(void)findAllBrands;
-(void)presentWebViewWithUrl:(NSString*)brandUrl;
-(void)presentBookingTestWithBrand:(MBrand *)brand;
@end
