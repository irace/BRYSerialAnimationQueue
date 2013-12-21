//
//  BRYViewController.m
//  BRYSerialAnimationExample
//
//  Created by Bryan Irace on 12/19/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "BRYSerialAnimationQueue.h"
#import "BRYViewController.h"

@interface BRYViewController()

@property (nonatomic) BRYSerialAnimationQueue *queue;
@property (nonatomic) UIButton *button;

@end

@implementation BRYViewController

- (id)init {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _queue = [[BRYSerialAnimationQueue alloc] init];
    }
    
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.button = [[UIButton alloc] init];
    [self.button setTitle:@"Tap me" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    [self.button sizeToFit];
    [self.button addTarget:self action:@selector(showMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.button.frame = ({
        CGRect viewBounds = self.view.bounds;
        
        CGRect bounds = self.button.bounds;
        bounds.origin.x = floorf((CGRectGetWidth(viewBounds) - CGRectGetWidth(bounds))/2);
        bounds.origin.y = floorf((CGRectGetHeight(viewBounds) - CGRectGetHeight(bounds))/2);
        bounds;
    });
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self init];
}

#pragma mark - Actions

- (void)showMessage {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor redColor];
    label.text = @"You'll only see one of me at a time!";
    label.backgroundColor = [UIColor redColor];
    [label sizeToFit];
    [self.view addSubview:label];
    
    void (^updateLabelOriginY)(CGFloat) = ^(CGFloat originY) {
        CGRect frame = label.frame;
        frame.origin.y = originY;
        label.frame = frame;
    };
    
    updateLabelOriginY(-CGRectGetHeight(label.frame));
    
    [self.queue animateWithDuration:0.5 animations:^{
        updateLabelOriginY(0);
    }];
    
    [self.queue animateWithDuration:0.5 delay:0.5 options:0 animations:^{
        updateLabelOriginY(-CGRectGetHeight(label.frame));
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}

@end
