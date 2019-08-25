//
//  VFCategoriesCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VFCategoriesCell.h"
#import "UIView+Border.h"
#import "UIView+Roundify.h"

@implementation VFCategoriesCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    [_btnSuv titleLabel].lineBreakMode = NSLineBreakByTruncatingTail;
    [_btnSuv titleLabel].numberOfLines = 2;
    [_btnSuv titleLabel].textAlignment = NSTextAlignmentCenter;
    [_btnSuv titleLabel].adjustsFontSizeToFitWidth = YES;
    [_btnSuv titleLabel].minimumScaleFactor = 0.5;
    
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
            [subview isKindOfClass:[UIButton class]]) {
            if (subview != _btnSuv) {
                [subview.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : -1,1)];
            }
        }
    }
    
    self.lbTitleVehicle.text = LOCALIZED(@"TEXT TITLE VEHICLE");
    [_btnAll setTitle:LOCALIZED(@"TEXT TAB ALL") forState:UIControlStateNormal];
    [_btnSedan setTitle:LOCALIZED(@"TEXT TAB SEDAN") forState:UIControlStateNormal];
    [_btnSuv setTitle:LOCALIZED(@"TEXT TAB SUV") forState:UIControlStateNormal];
    [_btnTrucks setTitle:LOCALIZED(@"TEXT TAB TRUCKS") forState:UIControlStateNormal];
    [_btnOthers setTitle:LOCALIZED(@"TEXT TAB CROSSOVERS") forState:UIControlStateNormal];
    [[_btnSuv titleLabel] setFont:[UIFont boldSystemFontOfSize:([ATMGlobal isEnglish] ? 12 : 11)]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

- (IBAction)selectCategoryAction:(id)sender {
    NSInteger tag = [sender tag];
    NSArray *buttons = @[_btnAll, _btnSedan, _btnSuv, _btnTrucks, _btnOthers];
    
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
        NSString *category = [@[@"ALL", @"SEDAN", @"SUV", @"TRUCK", @"CROSSOVER"][tag] lowercaseString];
        [_delegate changeCagetory:category];
    }
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [_btnAll addRoundedCorners:([ATMGlobal isEnglish] ? UIRectCornerTopLeft : UIRectCornerTopRight)
                     withRadii:CGSizeMake(4, 4)];
    [_btnOthers addRoundedCorners:([ATMGlobal isEnglish] ? UIRectCornerTopRight : UIRectCornerTopLeft)
                     withRadii:CGSizeMake(6, 6)];
    
}
@end
