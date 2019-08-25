//
//  ServicePopupDismissalTransition.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ServicePopupDismissalTransition.h"
#import "ServicePopupViewController.h"

@implementation ServicePopupDismissalTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.72;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ServicePopupViewController *fromVC = (ServicePopupViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGPoint finalCenter = CGPointMake(160.0f, (fromVC.view.bounds.size.height / 2) - 1000.0f);
    
    [UIView
     animateWithDuration:[self transitionDuration:transitionContext]
     delay:0.0f
     usingSpringWithDamping:0.64f
     initialSpringVelocity:0.22f
     options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowAnimatedContent
     animations:^{
         fromVC.view.center = finalCenter;
         fromVC.transitioningBackgroundView.alpha = 0.0f;
     } completion:^(BOOL finished) {
         [fromVC.view removeFromSuperview];
         [transitionContext completeTransition:YES];
         [[UIApplication sharedApplication].keyWindow addSubview:toVC.view];
     }];
}

@end
