//
//  OFCategoriesCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "OFCategoriesCell.h"
#import "UIView+Border.h"
#import "UIView+Roundify.h"

@implementation OFCategoriesCell

- (void)awakeFromNib {
    // Initialization code
    _lbHeadline.text = LOCALIZED(@"TEXT VEHICLE OFFERS");
    [@[_lbHeadline, _btnNew, _btnPreOwned, _btnService] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        AFFINE_TRANSFORM(view);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

- (IBAction)selectCategoryAction:(id)sender {
    NSInteger tag = [sender tag];
    NSArray *buttons = @[_btnNew, _btnPreOwned, _btnService];
    
    [buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == tag) {
            [btn setTitleColor:[UIColor colorWithRed:0 green:20/255.f blue:88/255.f alpha:1.0] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor whiteColor]];
        } else {
            [btn setTitleColor:[UIColor colorWithRed:236/255.f green:236/255.f blue:236/255.f alpha:1.0] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor colorWithRed:171/255.f green:171/255.f blue:171/255.f alpha:1.0]];
        }
    }];
    
    if (_delegate) {
        NSString *category = kOfferCatNew;
        if ([sender tag] == 1) {
            category = kOfferCatPreowned;
        } else if ([sender tag] == 2) {
            category = kOfferCatService;
        }
        [_delegate changeCagetory:category];
    }
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [_btnNew addRoundedCorners:[ATMGlobal isEnglish] ? UIRectCornerTopLeft : UIRectCornerTopRight
                     withRadii:CGSizeMake(6, 6)];
    [_btnService addRoundedCorners:[ATMGlobal isEnglish] ? UIRectCornerTopRight : UIRectCornerTopLeft
                         withRadii:CGSizeMake(6, 6)];
}

@end
