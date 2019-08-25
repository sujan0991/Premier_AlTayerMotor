//
//  LoadingInteractorIO.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/2/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MToken;

@protocol LoadingInteractorInput <NSObject>
- (void)startSyncing;
@end


@protocol LoadingInteractorOutput <NSObject>
- (void)didCompleteSyncing;
@end
