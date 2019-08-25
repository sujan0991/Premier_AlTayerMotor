//
//  OFCategoriesCell.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OfferCategoryDelegate <NSObject>
-(void)changeCagetory:(NSString*)category;
@end

@interface OFCategoriesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnPreOwned;
@property (weak, nonatomic) IBOutlet UIButton *btnNew;
@property (weak, nonatomic) IBOutlet UIButton *btnService;
@property (weak, nonatomic) IBOutlet UILabel *lbHeadline;
@property (weak, nonatomic) id<OfferCategoryDelegate> delegate;

- (IBAction)selectCategoryAction:(id)sender;

@end
