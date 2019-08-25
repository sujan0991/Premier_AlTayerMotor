//
//  OffersFilterViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"

@class OffersFilterDisplayData;

@interface OffersFilterViewController : BaseViewController
@property (nonatomic, strong) OffersFilterDisplayData *data;
@property (nonatomic, strong) NSString *selectedCategory;
@property (nonatomic, assign) NSInteger selectedBrand;
@end
