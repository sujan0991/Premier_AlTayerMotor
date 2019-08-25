//
//  ServicesVehicleCell.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/5/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServicesVehicleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imvVehicle;
@property (weak, nonatomic) IBOutlet UILabel *lbModel;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
@end
