//
//  DataManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+ (id)sharedManager;

- (void)importDefaultData;

@end
