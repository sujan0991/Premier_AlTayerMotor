//
//  VehicleCell.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehicleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imvVehicle;
@property (weak, nonatomic) IBOutlet UILabel *lbModelYear;
@property (weak, nonatomic) IBOutlet UILabel *lbBrand;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UIView *informationView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UILabel *lbMileage;
@property (weak, nonatomic) IBOutlet UILabel *lbModelYeardt;
@property (weak, nonatomic) IBOutlet UILabel *lbTrim;
@property (weak, nonatomic) IBOutlet UILabel *lbColor;

@end
