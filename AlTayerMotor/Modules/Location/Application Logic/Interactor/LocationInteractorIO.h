//
//  LocationInteractorIO.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/8/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LocationInteractorInput <NSObject>
- (void)findLocations;
@end

@protocol LocationInteractorOutput <NSObject>
- (void)foundLocations:(NSArray *)locations;
@end
