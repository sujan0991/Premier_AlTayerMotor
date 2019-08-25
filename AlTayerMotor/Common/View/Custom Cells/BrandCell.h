//
//  BrandCell.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrandCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imvLogo;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (assign, nonatomic) BOOL lastRow;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *line;

@end
