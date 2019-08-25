//
//  BrandsViewInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BrandsDisplayData;
@class MUser;

@protocol BrandsViewInterface <NSObject>
- (void)showBrandsDisplayData:(BrandsDisplayData *)data;
- (void)showUserInfo:(MUser *)user;
@end
