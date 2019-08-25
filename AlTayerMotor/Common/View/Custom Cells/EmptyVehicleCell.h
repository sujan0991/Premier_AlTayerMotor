//
//  EmptyVehicleCell.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/16/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyVehicleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imvCar;
@property (weak, nonatomic) IBOutlet UILabel *lbEmpty;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIWebView *wvEmpty;

@end
