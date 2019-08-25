//
//  FTRegisteredCarCell.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTRegisteredCarCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnEditRegisteredCar;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteRegisteredCar;
@property (weak, nonatomic) IBOutlet UILabel *lbCarType;
@property (weak, nonatomic) IBOutlet UILabel *lbRegNo;
@property (weak, nonatomic) IBOutlet UILabel *lbExpiryDate;
@property (weak, nonatomic) IBOutlet UILabel *lbModel;
@property (weak, nonatomic) IBOutlet UIImageView *imvModel;

@end
