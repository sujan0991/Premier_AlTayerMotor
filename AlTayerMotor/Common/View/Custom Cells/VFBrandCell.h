//
//  VFBrandCell.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VehiclesFilterDisplayData;
@class MPreownedVehicleModel;

@interface VFBrandCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *lbModel;
@property (weak, nonatomic) IBOutlet UIImageView *imvCheckmark;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;
@property (assign, nonatomic) BOOL lastRow;

@property (strong, nonatomic) MPreownedVehicleModel *selectedModel;
@property (weak, nonatomic) MPreownedVehicleModel *vehicleModel;

- (void)displayModel:(MPreownedVehicleModel *)vehicleModel shownType:(BOOL)shownType;

@end
