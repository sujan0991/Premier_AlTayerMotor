//
//  LocationPresenter.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LocationPresenter.h"

@implementation LocationPresenter

#pragma mark - Module Interface
- (void)findLocations
{
    [self.interactor findLocations];
}

- (void)showSelectionsInLocation:(MLocation *)location
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select Action"
                                                                         message:@""
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT CANCEL CAPITALIZE") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [actionSheet dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT CALL") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.userInterface callToLocation:location];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT GET DIRECTION") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.userInterface routeToLocation:location];
    }]];
    
    [self.userInterface presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - Interactor
- (void)foundLocations:(NSArray *)locations
{
    [self.userInterface updateLocations:locations];
}


@end
