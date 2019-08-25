//
//  RoadsidePresenter.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "RoadsidePresenter.h"
#import "RoadsideViewInterface.h"
#import "ATMTabBarViewController.h"
#import "BookingTestViewController.h"

@implementation RoadsidePresenter

#pragma mark - Module Interface
- (void)findAllBrands
{
    [self.interactor findAllBrands];
}

#pragma mark - View Interface
- (void)foundAllBrands:(NSArray *)brands
{
    [self.userInterface foundAllBrands:brands];
}

@end