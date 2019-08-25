//
//  BrandOfferCell.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BrandOffersDisplayData;
@class BrandOfferCell;

@protocol BrandOfferCellDelegate <NSObject>
- (void)brandOfferCell:(BrandOfferCell *)cell showOfferAtIndex:(NSInteger)index;
@end

@interface BrandOfferCell : UITableViewCell <UIScrollViewDelegate>

@property (strong, nonatomic) BrandOffersDisplayData *data;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) id<BrandOfferCellDelegate> delegate;

- (void)setOffersData:(BrandOffersDisplayData *)data;

@end
