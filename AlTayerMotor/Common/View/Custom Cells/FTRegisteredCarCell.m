//
//  FTRegisteredCarCell.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "FTRegisteredCarCell.h"

@implementation FTRegisteredCarCell

- (void)awakeFromNib {
    // Initialization code
    for (UIView *subview in [self allSubviews]) {
        AFFINE_TRANSFORM(subview);
    }
    
    [@[_lbCarType, _lbExpiryDate, _lbModel, _lbRegNo] enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TEXT_ALIGN(obj);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
