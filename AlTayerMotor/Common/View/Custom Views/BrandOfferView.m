//
//  BrandOfferView.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BrandOfferView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MOffer.h"
#import "NSString+Utils.h"

@interface BrandOfferView()
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@end

@implementation BrandOfferView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
    self.lbContent.textAlignment = [ATMGlobal isEnglish] ? NSTextAlignmentLeft : NSTextAlignmentRight;
    self.lbDescription.textAlignment = [ATMGlobal isEnglish] ? NSTextAlignmentLeft : NSTextAlignmentRight;
    self.lbName.textAlignment = [ATMGlobal isEnglish] ? NSTextAlignmentLeft : NSTextAlignmentRight;
}

- (void)displayOffer:(MOffer *)offer
{
    self.offer = offer;

    [self.imvPoster sd_setImageWithURL:[NSURL URLWithString:[offer.thumbnailUrl toImageLink]]
                      placeholderImage:[UIImage imageNamed:@"placeholder_car"]];
    
    NSString *title = [offer isValidString:offer.title] ? offer.title : @"";
    [self.lbName setText:[title uppercaseString]];
    
    NSString *description = [offer isValidString:offer.desc] ? offer.desc : @"";
    [self.lbDescription setText:[description uppercaseString]];
    
    NSString *currency = [offer isValidString:offer.currency] ? offer.currency : @"AED";
    NSString *price = [self.numberFormatter stringFromNumber:@(offer.price)];
    self.lbContent.text = [NSString stringWithFormat:@"%@ %@ %@", LOCALIZED(@"TEXT STARTING AT"), currency, price];
    self.lbContent.hidden = offer.price == 0;
    
    [self layoutByLanguage];
}

- (NSNumberFormatter *)numberFormatter
{
    if (!_numberFormatter) {
        _numberFormatter = [[NSNumberFormatter alloc]init];
        [_numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [_numberFormatter setGroupingSeparator:@","];
        [_numberFormatter setGroupingSize:3];
    }
    
    return _numberFormatter;
}
@end
