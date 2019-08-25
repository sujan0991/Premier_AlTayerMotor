//
//  PeekOffersWireframe.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeekOffersWireframe : NSObject
- (void)presentPeekOffersInterfaceWithData:(NSArray *)offers
                                   atIndex:(NSInteger)index
                            inInNavigation:(UINavigationController *)navigationController;
@end
