//
//  RightMenuCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/19/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "RightMenuCell.h"
#import "UIView+Utils.h"

@implementation RightMenuCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutByLanguage)
                                                 name:kNotificationLanguageDidChange
                                               object:nil];
}

- (void)layoutByLanguage
{
    for (UIView *subview in [self allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]] ||
            [subview isKindOfClass:[UIImageView class]]) {
            AFFINE_TRANSFORM(subview);
        }
    }
    
    TEXT_ALIGN(_lbTitle);
}

@end
