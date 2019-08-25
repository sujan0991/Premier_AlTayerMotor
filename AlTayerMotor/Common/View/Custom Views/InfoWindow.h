//
//  InfoWindow.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/8/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoWindow : UIView

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbCity;
@property (weak, nonatomic) IBOutlet UILabel *lbFirst;
@property (weak, nonatomic) IBOutlet UILabel *lbSecond;
@property (weak, nonatomic) IBOutlet UILabel *lbThird;
@property (weak, nonatomic) IBOutlet UIButton *btnCall;
@property (weak, nonatomic) IBOutlet UIButton *btnDirection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;


@end
