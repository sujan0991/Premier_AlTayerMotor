//
//  FirstTimeViewController.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/15/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "FirstTimeViewInterface.h"

@protocol FirstTimeModuleInterface;

@interface FirstTimeViewController : BaseViewController<FirstTimeViewInterface, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) id<FirstTimeModuleInterface> eventHandler;

@end