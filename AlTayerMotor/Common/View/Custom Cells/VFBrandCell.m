//
//  VFBrandCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VFBrandCell.h"
#import "MPreownedVehicleModel.h"
#import "VehiclesFilterDisplayData.h"
#import "UIView+Roundify.h"

@implementation VFBrandCell

-(void)awakeFromNib
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
    
    self.lbModel.textAlignment = [ATMGlobal isEnglish] ? NSTextAlignmentLeft : NSTextAlignmentRight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
        
    if (selected) {
        self.selectedModel = self.vehicleModel;
    }
    
    self.imvCheckmark.hidden = !selected;
}

- (void)displayModel:(MPreownedVehicleModel *)vehicleModel shownType:(BOOL)shownType
{
    if (shownType && vehicleModel.type && ![vehicleModel isEqual:[NSNull null]] && vehicleModel.type.length > 0) {
//        self.lbModel.text = [[NSString stringWithFormat:@"%@ (%@)", vehicleModel.model, vehicleModel.type] uppercaseString];
        self.lbModel.text = [[NSString stringWithFormat:@"%@", vehicleModel.model] uppercaseString];
    } else {
        self.lbModel.text = [vehicleModel.model uppercaseString];
    }
    
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.lastRow) {
        [_bgView addRoundedCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft
                         withRadii:CGSizeMake(4, 4)];
    } else {
        [_bgView addRoundedCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft
                         withRadii:CGSizeMake(0, 0)];
    }
}

@end
