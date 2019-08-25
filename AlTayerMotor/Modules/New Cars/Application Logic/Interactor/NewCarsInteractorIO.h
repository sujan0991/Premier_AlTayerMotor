
//
//  NewCarsInteractorIO.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewCarsInteractorInput <NSObject>
-(void)findAllBrands;
@end

@protocol NewCarsInteractorOutput <NSObject>
- (void)foundAllBrands:(NSArray *)brands;
@end
