//
//  WelcomeCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 2/1/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import "WelcomeCell.h"

@implementation WelcomeCell

- (void)awakeFromNib {
    // Initialization code
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutByLanguage)
                                                 name:kNotificationLanguageDidChange
                                               object:nil];
    
    [self layoutByLanguage];
}

- (void)layoutByLanguage
{
    AFFINE_TRANSFORM(_lbTitle);
    AFFINE_TRANSFORM(_lbDescription);
    _lbTitle.text = LOCALIZED(@"TEXT WELCOME");
    _lbDescription.text = LOCALIZED(@"TEXT WELCOME DESCRIPTION");
    TEXT_ALIGN(_lbDescription);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
