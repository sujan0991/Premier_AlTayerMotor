//
//  CALayer+Utils.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/18/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import "CALayer+Utils.h"

@implementation CALayer (Utils)

- (NSArray *)allSubLayers
{
    NSMutableArray *arr = [@[] mutableCopy];
    for (CALayer *layer in self.sublayers) {
        [arr addObject:layer];
        [arr addObjectsFromArray:[layer allSubLayers]];
    }
    return arr;
}

@end
