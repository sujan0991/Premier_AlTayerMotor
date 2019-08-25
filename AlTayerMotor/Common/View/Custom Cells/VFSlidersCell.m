//
//  VFSlidersCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VFSlidersCell.h"
#import "NMRangeSlider.h"
#import "ViewUtils.h"
#import "VehiclesFilterDisplayData.h"
#import "DateManager.h"

@implementation VFSlidersCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupViews];
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
    
    self.lbTitleMileage.text = LOCALIZED(@"TEXT TITLE MILEAGE");
    self.lbTitlePrice.text = LOCALIZED(@"TEXT TITLE PRICE");
    self.lbTitleYear.text = LOCALIZED(@"TEXT TITLE YEAR");
}

- (void)setupViews
{
    [self configPriceSlider];
    [self configMileageSlider];
    [self configYearSlider];
}

- (void) configMileageSlider
{
    _sliderMileage.minimumValue = 0;
    _sliderMileage.maximumValue = 200000;
    _sliderMileage.lowerHandleHidden = YES;
    _sliderMileage.upperValue = 200000;
    _sliderMileage.stepValue = 10000;
    _sliderMileage.stepValueContinuously = NO;
    _sliderMileage.backgroundColor = [UIColor clearColor];

    UIImage *image = nil;
    image = [UIImage imageNamed:@"slider_background"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    _sliderMileage.trackBackgroundImage = image;
    
    image = [UIImage imageNamed:@"slider_track"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    _sliderMileage.trackImage = image;
    
    image = [UIImage imageNamed:@"slider_handle"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    _sliderMileage.lowerHandleImageNormal = image;
    _sliderMileage.upperHandleImageNormal = image;
    _sliderMileage.lowerHandleImageHighlighted = image;
    _sliderMileage.upperHandleImageHighlighted = image;
}

- (void) configPriceSlider
{
    _sliderPrice.minimumValue = 0;
    _sliderPrice.maximumValue = 300;
    _sliderPrice.lowerValue = 0;
    _sliderPrice.upperValue = 300;
    _sliderPrice.stepValue = 5;
    _sliderPrice.stepValueContinuously = NO;
    _sliderPrice.backgroundColor = [UIColor clearColor];
    
    UIImage *image = nil;
    image = [UIImage imageNamed:@"slider_background"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    _sliderPrice.trackBackgroundImage = image;
    
    image = [UIImage imageNamed:@"slider_track"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    _sliderPrice.trackImage = image;
    
    image = [UIImage imageNamed:@"slider_handle"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    _sliderPrice.lowerHandleImageNormal = image;
    _sliderPrice.upperHandleImageNormal = image;
    _sliderPrice.lowerHandleImageHighlighted = image;
    _sliderPrice.upperHandleImageHighlighted = image;
}

- (void) configYearSlider
{
    NSDate *currentDate = [NSDate date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:currentDate];
    NSInteger currentMonth = [components month];
    DLog(@"%ld", currentMonth);
    
    NSString *yearString = [[[DateManager sharedManager] yearFormatter] stringFromDate:currentDate];
    NSInteger currentYear = [yearString integerValue] + (currentMonth > 3 ? 1 : 0);
    NSInteger minYear = self.data.oldestYear == 0 ? currentYear - 30 : self.data.oldestYear;
    
    _sliderYear.minimumValue = minYear;
    _sliderYear.maximumValue = currentYear;
    _sliderYear.lowerValue = minYear;
    _sliderYear.upperValue = currentYear;
    _sliderYear.stepValue = 1;
    _sliderYear.stepValueContinuously = NO;
    _sliderYear.backgroundColor = [UIColor clearColor];
    
    UIImage *image = nil;
    image = [UIImage imageNamed:@"slider_background"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    _sliderYear.trackBackgroundImage = image;
    
    image = [UIImage imageNamed:@"slider_track"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    _sliderYear.trackImage = image;
    
    image = [UIImage imageNamed:@"slider_handle"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    _sliderYear.lowerHandleImageNormal = image;
    _sliderYear.upperHandleImageNormal = image;
    _sliderYear.lowerHandleImageHighlighted = image;
    _sliderYear.upperHandleImageHighlighted = image;
}


- (void)setData:(VehiclesFilterDisplayData *)data
{
    if (!_data) {
        _data = data;
    }
    
    _sliderPrice.lowerValue = MAX(_data.lowerPrice, 0);
    _sliderPrice.upperValue = (_data.upperPrice > 0 && _data.upperPrice < 300) ? _data.upperPrice : 300;

    _sliderMileage.upperValue = _data.upperMileage > 10 ? _data.upperMileage : 200000;
    
    NSDate *currentDate = [NSDate date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:currentDate];
    NSInteger currentMonth = [components month];
    NSString *yearString = [[[DateManager sharedManager] yearFormatter] stringFromDate:currentDate];
    NSInteger currentYear = [yearString integerValue] + (currentMonth > 3 ? 1 : 0);
    NSInteger minYear = self.data.oldestYear == 0 ? currentYear - 30 : self.data.oldestYear;
    
    _sliderYear.minimumValue = minYear;
    _sliderYear.lowerValue = _data.lowerYear > minYear ? _data.lowerYear : minYear;
    _sliderYear.upperValue = (_data.upperYear > 0 && _data.upperYear < currentYear) ? _data.upperYear : currentYear;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // Configure the view for the selected state
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}

@end
