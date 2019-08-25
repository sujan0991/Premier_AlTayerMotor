//
//  LatestOfferCell.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWParallaxScrollView.h"

@interface LatestOfferCell : UITableViewCell<PWParallaxScrollViewDataSource, PWParallaxScrollViewDelegate>

@property (strong, nonatomic) IBOutlet PWParallaxScrollView *scrollView;

@end
