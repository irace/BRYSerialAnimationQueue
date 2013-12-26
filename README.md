# BRYSerialAnimationQueue

Perform UIView animations serially without blocking the main thread, using the same APIs you already know and love.

## Installation

Via [CocoaPods](http://cocoapods.org), of course:

    pod "BRYSerialAnimationQueue"

## Why?

The main goal of the class is to make it easy to perform event-based animations (e.g. a user taps a button or a network callback completes). One perfect example is displaying banners inside of an application when push notifications are received. Simply add animation blocks to a `BRYSerialAnimationQueue` instance and they'll be executed only once all of the previously queued animations have completed.

An added benefit is that nested animation code like this:

```objective-c
[UIView animateWithDuration:duration animations:^{
    label.alpha = 1;

} completion:^(BOOL finished) {
    [UIView animateWithDuration:duration delay:delay animations:^{
        label.alpha = 0;

    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}];
```

Can be replaced with something a little cleaner, like:

```objective-c
[queue animateWithDuration:duration animations:^{
    label.alpha = 1;
}];

[queue animateWithDuration:duration delay:delay animations:^{
    label.alpha = 0;

} completion:^(BOOL finished) {
    [label removeFromSuperview];
}];
```

## License
Available for use under the MIT license: [http://bryan.mit-license.org](http://bryan.mit-license.org)
