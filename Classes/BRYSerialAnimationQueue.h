//
//  BRYSerialAnimationQueue.h
//  BRYSerialAnimationQueue
//
//  Created by Bryan Irace on 12/19/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

@import UIKit;

/**
 Perform UIView animations serially without blocking the main thread, using the same APIs you already know and love.
 
 The main goal of the class is to make it easy to perform event-based animations (e.g. a user taps a button or a network callback completes). One perfect example is displaying banners inside of an application when push notifications are received. Simply add animation blocks to a `BRYSerialAnimationQueueInstance` and they'll be executed only once all of the previously queued animations have completed.
 
 An added benefit is that nested animation code like this:
 
     [UIView animateWithDuration:duration animations:^{
        label.alpha = 1;
     
     } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:delay animations:^{
            label.alpha = 0;
     
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
     }];
 
 Can be replaced with something a little cleaner, like:
 
    [queue animateWithDuration:duration animations:^{
        label.alpha = 1;
    }];
 
    [queue animateWithDuration:duration delay:delay animations:^{
        label.alpha = 0;
 
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
 */
@interface BRYSerialAnimationQueue : NSObject

- (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options
                 animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;

- (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations
                 completion:(void (^)(BOOL finished))completion;

- (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations;

- (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)dampingRatio
      initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^)(void))animations
                 completion:(void (^)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);

@end
