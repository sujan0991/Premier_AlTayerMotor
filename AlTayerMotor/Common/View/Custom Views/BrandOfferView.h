//
//  BrandOfferView.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MOffer;

@interface BrandOfferView : UIView

@property (nonatomic, weak) MOffer *offer;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbDescription;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UIImageView *imvPoster;
@property (weak, nonatomic) IBOutlet UIButton *btnOffer;

- (void)displayOffer:(MOffer *)offer;

@end
