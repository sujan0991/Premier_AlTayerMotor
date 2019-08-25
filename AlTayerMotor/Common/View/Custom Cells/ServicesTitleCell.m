//
//  ServicesTitleCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/25/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import "ServicesTitleCell.h"

@implementation ServicesTitleCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    for (UIView *subview in [self allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]] ||
            [subview isKindOfClass:[UIImageView class]]) {
            [subview.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : -1,1)];
        }
    }
    
    _imvTitle.hidden = ![ATMGlobal isEnglish];
    _imvTitleAR.hidden = [ATMGlobal isEnglish];
}

@end
