//
//  VehiclesFilterViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"

@class VehiclesFilterDisplayData;

@interface VehiclesFilterViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) VehiclesFilterDisplayData *data;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
