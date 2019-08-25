//
//  RoadsideInteractorIO.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RoadsideInteractorInput <NSObject>
-(void)findAllBrands;
@end

@protocol RoadsideInteractorOutput <NSObject>
- (void)foundAllBrands:(NSArray *)brands;
@end
