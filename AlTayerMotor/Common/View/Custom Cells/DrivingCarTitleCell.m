//
//  DrivingCarTitleCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 2/2/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import "DrivingCarTitleCell.h"

@implementation DrivingCarTitleCell

- (void)awakeFromNib {
    // Initialization code
    AFFINE_TRANSFORM(_iconCar);
    AFFINE_TRANSFORM(_lbTitle);
    _lbTitle.text = LOCALIZED(@"TEXT WHAT ARE YOU DRIVING?");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
