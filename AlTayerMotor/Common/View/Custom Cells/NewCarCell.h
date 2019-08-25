//
//  NewCarCell.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Roundify.h"

@interface NewCarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imvBrand;
@property (weak, nonatomic) IBOutlet UILabel *lbBrand;
@property (weak, nonatomic) IBOutlet UIButton *btnBooking;
@property (weak, nonatomic) IBOutlet UIButton *btnWeb;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (assign, nonatomic) BOOL lastRow;
@end
