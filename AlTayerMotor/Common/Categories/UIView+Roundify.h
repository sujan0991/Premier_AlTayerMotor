//
//  NSString+Roundify.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (Roundify)
-(void)addRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii;
-(CALayer*)maskForRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii;
@end
