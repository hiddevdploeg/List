//
//  OCTListActivityItemSource.m
//  List
//
//  Created by Steven Roebert on 08-09-2014.
//  Copyright (c) 2014 Octoo Apps. All rights reserved.
//

#import "OCTListActivityItemSource.h"

@implementation OCTListActivityItemSource

#pragma mark - Initialize

- (instancetype)initWithTasks:(NSArray *)tasks completedTasks:(NSArray *)completedTasks {
    if ((self = [super init])) {
        _tasks = [tasks copy];
        _completedTasks = [completedTasks copy];
    }
    return self;
}

#pragma mark - UIActivityItemSource

- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController {
    return @"";
}

- (id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType {
    // Hier kan je de tekst voor de email maken.
    NSMutableString *emailText = [NSMutableString string];
    [emailText appendString:[self.tasks componentsJoinedByString:@"\n"]];
    

   
    
    return emailText;
}

- (NSString *)activityViewController:(UIActivityViewController *)activityViewController subjectForActivityType:(NSString *)activityType {
    return @"Here's my list for you!";
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake)
    {
        NSLog(@"Shake");
    }}
    @end
