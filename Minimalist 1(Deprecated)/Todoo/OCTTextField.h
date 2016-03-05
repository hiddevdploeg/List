//
//  OCTTextField.h
//  List
//
//  Created by Rajesh Rao on 10/6/14.
//  Copyright (c) 2014 Octoo Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OCTTextFieldDelegate;

@interface OCTTextField : UITextField


@property (nonatomic, assign) id<OCTTextFieldDelegate> textFieldDelegate;

@end

@protocol OCTTextFieldDelegate <NSObject>
@required
- (void)didShakeForTextField:(OCTTextField *)textField;

@end