//
//  BrandTitleCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BrandTitleCell.h"
#import "UIView+Roundify.h"

@implementation BrandTitleCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutByLanguage)
                                                 name:kNotificationLanguageDidChange
                                               object:nil];
    [self layoutByLanguage];
}

- (void)layoutByLanguage
{
    for (UIView *subview in [self allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]] ||
            [subview isKindOfClass:[UIImageView class]]) {
            [subview.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : -1,1)];
        }
    }
    self.lbTitle.text = LOCALIZED(@"TEXT TITLE BRANDS");
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [_bgView addRoundedCorners:UIRectCornerTopRight | UIRectCornerTopLeft
                     withRadii:CGSizeMake(6, 6)];
}

@end
