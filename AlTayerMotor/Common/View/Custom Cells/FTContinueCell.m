//
//  FTContinueCell.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "FTContinueCell.h"

@implementation FTContinueCell

- (void)awakeFromNib {
    // Initialization code
    AFFINE_TRANSFORM(_btnContinue);
    [_btnContinue setTitle:LOCALIZED(@"TEXT CONTINUE")
                  forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
