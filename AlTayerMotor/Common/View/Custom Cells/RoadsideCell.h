//
//  RoadsideCell.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoadsideCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imvBrand;
@property (weak, nonatomic) IBOutlet UILabel *lbBrand;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *btnPhone;
@property (assign, nonatomic) BOOL lastRow;
@end