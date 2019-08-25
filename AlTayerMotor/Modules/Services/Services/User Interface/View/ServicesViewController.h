//
//  ServicesViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/5/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "ServicesModuleInterface.h"
#import "ServicesViewInterface.h"

@interface ServicesViewController : BaseViewController<ServicesViewInterface>

@property (nonatomic, strong) id<ServicesModuleInterface> eventHandler;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
