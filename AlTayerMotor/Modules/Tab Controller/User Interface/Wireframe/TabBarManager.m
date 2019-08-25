//
//  TabBarManager.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "TabBarManager.h"

@implementation TabBarManager

+ (id)sharedManager {
    static TabBarManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        self.subViewControllers = [@[] mutableCopy];
        self.reversedSubViewControllers = [@[] mutableCopy];
    }
    return self;
}


@end
