//
//  BrandsInteractorIO.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MUser;

@protocol BrandsInteractorInput <NSObject>
-(void)findAllBrands;
-(void)findUserInfo;
@end

@protocol BrandsInteractorOutput <NSObject>
- (void)foundAllBrands:(NSArray *)brands;
- (void)foundUserInfo:(MUser *)user;
@end