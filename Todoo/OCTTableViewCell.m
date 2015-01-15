//
//  OCTTableViewCell.m
//  List
//
//  Created by Hidde van der Ploeg on 08-09-14.
//  Copyright (c) 2014 Octoo Apps. All rights reserved.
//

#import "OCTTableViewCell.h"

@implementation OCTTableViewCell {
    UIView *_separatorView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        // Create the separator view, set the background color and add it to the cell
        _separatorView = [[UIView alloc] init];
        _separatorView.backgroundColor = [UIColor colorWithRed:0.768 green:0.792 blue:0.8 alpha:1];
        [self.contentView addSubview:_separatorView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Set the frame of the separator to be at the bottom of the cell (1 pixel)
    _separatorView.frame = CGRectMake(0, CGRectGetHeight(self.contentView.bounds) - 1, CGRectGetWidth(self.contentView.bounds), 1);
    
    // Make sure that the separator view is on top of the text label
    [self.contentView bringSubviewToFront:_separatorView];
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