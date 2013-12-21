//
//  BRYSerialAnimationQueue.m
//  BRYSerialAnimationQueue
//
//  Created by Bryan Irace on 12/19/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "BRYSerialAnimationQueue.h"

@interface BRYSerialAnimationQueue()

@property (nonatomic) dispatch_queue_t queue;
@property (nonatomic) dispatch_semaphore_t semaphore;

@end

@implementation BRYSerialAnimationQueue

#pragma mark - NSObject

- (id)init {
    if (self = [super init]) {
        _queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
    }
    
    return self;
}

#pragma mark - BRYSerialAnimationQueue

- (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options
                 animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion {
    [self performAnimationsSerially:^{
        [UIView animateWithDuration:duration delay:delay options:options animations:animations completion:^(BOOL finished) {
            [self runCompletionBlock:completion animationDidFinish:finished];
        }];
    }];
}

- (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations
                 completion:(void (^)(BOOL finished))completion {
    [self performAnimationsSerially:^{
        [UIView animateWithDuration:duration animations:animations completion:^(BOOL finished) {
            [self runCompletionBlock:completion animationDidFinish:finished];
        }];
    }];
}

- (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations {
    [self performAnimationsSerially:^{
        [UIView animateWithDuration:duration animations:animations completion:^(BOOL finished) {
            [self runCompletionBlock:nil animationDidFinish:YES];
        }];
    }];
}

- (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)dampingRatio
      initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^)(void))animations
                 completion:(void (^)(BOOL finished))completion {
    [self performAnimationsSerially:^{
        [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:dampingRatio initialSpringVelocity:velocity
                            options:options animations:animations completion:^(BOOL finished) {
            [self runCompletionBlock:completion animationDidFinish:finished];
        }];
    }];
}

#pragma mark - Private

- (void)performAnimationsSerially:(void (^)(void))animation {
    dispatch_async(self.queue, ^{
        self.semaphore = dispatch_semaphore_create(0);
        
        dispatch_async(dispatch_get_main_queue(), animation);
        
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    });
}

- (void)runCompletionBlock:(void (^)(BOOL finished))completion animationDidFinish:(BOOL)finished {
    if (completion) {
        completion(finished);
    }
    
    dispatch_semaphore_signal(self.semaphore);
}

@end
