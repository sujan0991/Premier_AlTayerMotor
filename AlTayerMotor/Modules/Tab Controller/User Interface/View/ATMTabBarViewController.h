//
//  ATMTabBarViewController.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATMTabBarViewController : UITabBarController

- (void)showProfileInterface;
- (void)showNewCarsInterface;
- (void)showRoadsideAssistanceInterface;
- (void)showOffersInterface;
- (void)showEnquiryInterface;
- (void)call800Motors;
- (void)showAboutInterface;
- (UINavigationController *)getPreownedTab;

@end
