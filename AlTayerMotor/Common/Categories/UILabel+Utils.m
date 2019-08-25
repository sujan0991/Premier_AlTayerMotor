//
//  UILabel+Utils.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/30/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "UILabel+Utils.h"

@implementation UILabel (Utils)
- (CGFloat)getLabelHeight
{
    DLog(@"%@", @(self.frame.size.width));
    CGSize constraint = CGSizeMake(self.frame.size.width, 20000.0f);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [self.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:self.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}
@end
