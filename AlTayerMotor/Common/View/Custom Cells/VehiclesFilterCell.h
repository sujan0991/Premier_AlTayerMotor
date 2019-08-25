//
//  VehiclesFilterCell.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehiclesFilterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbFilterType;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIButton *btnAllVehicles;
@property (weak, nonatomic) IBOutlet UILabel *lbFilter;
@property (weak, nonatomic) IBOutlet UILabel *lbDisclaimerMsg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disclaimerMsgHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *btnDisclaimerMsg;
@property (assign, nonatomic) BOOL isOffer;

@end
