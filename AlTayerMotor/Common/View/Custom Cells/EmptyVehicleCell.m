//
//  EmptyVehicleCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/16/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "EmptyVehicleCell.h"

@implementation EmptyVehicleCell

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
    for (UIView *subview in [self allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]] || [subview isKindOfClass:[UIWebView class]] ) {
            [subview.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : -1,1)];
        }
    }
    
    self.lbEmpty.text = LOCALIZED(@"TEXT NO OFFER");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}

@end
