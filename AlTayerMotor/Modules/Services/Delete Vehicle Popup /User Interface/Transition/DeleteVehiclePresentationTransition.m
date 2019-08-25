//
//  DeleteVehiclePresentationTransition.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "DeleteVehiclePresentationTransition.h"
#import "DeleteVehicleViewController.h"
#import "UIImage+ImageEffects.h"

@implementation DeleteVehiclePresentationTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.72;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DeleteVehicleViewController *toVC = (DeleteVehicleViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIImageView *blurView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    blurView.alpha = 0.0f;
    
    UIGraphicsBeginImageContextWithOptions([[UIScreen mainScreen] bounds].size, NO, [[UIScreen mainScreen] scale]);
    [fromVC.view drawViewHierarchyInRect:[[UIScreen mainScreen] bounds] afterScreenUpdates:YES];
    
    UIImage *blurredImage = UIGraphicsGetImageFromCurrentImageContext();
    blurredImage = [blurredImage applyDarkEffect];
    
    UIGraphicsEndImageContext();
    
    blurView.image = blurredImage;
    
    toVC.transitioningBackgroundView = blurView;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:blurView];
    [containerView addSubview:toVC.view];
    
    CGRect toViewFrame = CGRectMake(0.0f, 0.0f, 314.0f, 178.0f);
    toVC.view.frame = toViewFrame;
    
    CGPoint finalCenter = CGPointMake(fromVC.view.bounds.size.width / 2, fromVC.view.bounds.size.height / 2);
    toVC.view.center = CGPointMake(finalCenter.x, finalCenter.y - 1000.0f);

    [UIView
     animateWithDuration:[self transitionDuration:transitionContext]
     delay:0.0f
     usingSpringWithDamping:0.64f
     initialSpringVelocity:0.22f
     options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowAnimatedContent
     animations:^{
         toVC.view.center = finalCenter;
         blurView.alpha = 0.7f;
     } completion:^(BOOL finished) {
         toVC.view.center = finalCenter;
         [transitionContext completeTransition:YES];
     }];
}

@end
