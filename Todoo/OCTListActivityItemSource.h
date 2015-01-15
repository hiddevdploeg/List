//
//  OCTListActivityItemSource.h
//  List
//
//  Created by Steven Roebert on 08-09-2014.
//  Copyright (c) 2014 Octoo Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCTListActivityItemSource : NSObject <UIActivityItemSource>

- (instancetype)initWithTasks:(NSArray *)tasks completedTasks:(NSArray *)completedTasks;
@property (nonatomic, readonly) NSArray *tasks;
@property (nonatomic, readonly) NSArray *completedTasks;

@end
