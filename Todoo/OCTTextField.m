//
//  OCTTextField.m
//  List
//
//  Created by Rajesh Rao on 10/6/14.
//  Copyright (c) 2014 Octoo Apps. All rights reserved.
//

#import "OCTTextField.h"

@implementation OCTTextField

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        [_textFieldDelegate didShakeForTextField:self];
    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
