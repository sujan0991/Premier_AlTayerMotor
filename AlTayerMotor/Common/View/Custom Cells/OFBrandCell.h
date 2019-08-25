//
//  OFBrandCell.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBrand;
@class OffersFilterDisplayData;

@protocol OFBrandCellDelegate <NSObject>
- (void)didSelectBrand:(MBrand *)brand;
@end

@interface OFBrandCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *imvLogo;
@property (weak, nonatomic) IBOutlet UILabel *lbModel;
@property (weak, nonatomic) IBOutlet UIImageView *imvCheckmark;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;
@property (assign, nonatomic) BOOL lastRow;
@property (weak, nonatomic) id<OFBrandCellDelegate> delegate;
@property (strong, nonatomic) MBrand *brand;

- (void)displayBrand:(MBrand *)brand;

@end
