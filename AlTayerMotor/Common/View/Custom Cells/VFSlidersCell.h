//
//  VFSlidersCell.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMARangeSlider;
@class NMRangeSlider;
@class VehiclesFilterDisplayData;

@interface VFSlidersCell : UITableViewCell

@property (strong, nonatomic) VehiclesFilterDisplayData *data;

@property (weak, nonatomic) IBOutlet NMRangeSlider *sliderPrice;
@property (weak, nonatomic) IBOutlet NMRangeSlider *sliderMileage;
@property (weak, nonatomic) IBOutlet NMRangeSlider *sliderYear;

@property (weak, nonatomic) IBOutlet UILabel *lbLowerPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbUpperPrice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLowerPrice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftUpperPrice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLowerPrice;

@property (weak, nonatomic) IBOutlet UILabel *lbTitlePrice;
@property (weak, nonatomic) IBOutlet UILabel *lbTitleMileage;
@property (weak, nonatomic) IBOutlet UILabel *lbTitleYear;

@property (weak, nonatomic) IBOutlet UILabel *lbMileageMin;
@property (weak, nonatomic) IBOutlet UILabel *lbMileageMax;
@property (weak, nonatomic) IBOutlet UILabel *lbMileage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMileage;

@property (weak, nonatomic) IBOutlet UILabel *lbLowerYear;
@property (weak, nonatomic) IBOutlet UILabel *lbUpperYear;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLowerYear;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftUpperYear;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLowerYear;
@end
