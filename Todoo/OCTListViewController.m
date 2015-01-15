//
//  OCTListViewController.m
//  Todoo
//
//  Created by Hidde van der Ploeg on 21-07-14.
//  Copyright (c) 2014 Octoo Apps. All rights reserved.
//

#import "OCTListViewController.h"
#import "OCTListActivityItemSource.h"
#import "OCTTableViewCell.h"
#import "OCTTextField.h"

@interface OCTListViewController () <UITextFieldDelegate, OCTTextFieldDelegate, UIScrollViewDelegate>
@property (nonatomic) NSMutableArray *tasks; // Main array for cells
@property (nonatomic) NSMutableArray *completedTasks;
@property (nonatomic) OCTTextField *addTask;

@end

@implementation OCTListViewController

#pragma mark - Viewcontroller
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView registerClass:[OCTTableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.rowHeight = 60.0f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.957 green:0.957 blue:0.965 alpha:1];
    
    
    //Pull To share
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    refreshControl.backgroundColor = [UIColor colorWithRed:0.133 green:0.45 blue:0.788 alpha:1];
    NSMutableAttributedString * release = [[NSMutableAttributedString alloc] initWithString:@"Pull to Share List"];
    [release addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,18)];
    [refreshControl setAttributedTitle:release];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(didTapShareButton) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    
    //Inputfield
    self.addTask = [[OCTTextField alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 304.0f, 30.0f)];
    [_addTask becomeFirstResponder];
    _addTask.textFieldDelegate = self;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    _addTask.leftView = paddingView;
    _addTask.leftViewMode = UITextFieldViewModeAlways;
    _addTask.returnKeyType = UIReturnKeyDone;
    _addTask.backgroundColor = [UIColor whiteColor];
    _addTask.placeholder = @"Add to List";
    _addTask.delegate = self;
    _addTask.layer.cornerRadius = 4;
    _addTask.clearButtonMode = UITextFieldViewModeWhileEditing;
    _addTask.layer.borderColor = [[UIColor whiteColor]CGColor];
    _addTask.layer.borderWidth=1.0;
    _addTask.enablesReturnKeyAutomatically = YES;
    
    
    [self.view endEditing:YES];
    
    //Set Navigationbar items
    self.navigationItem.titleView = _addTask;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    //Get the loaded tasks to store data
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *loadedTasks = [userDefaults arrayForKey:@"tasks"];
    self.tasks = [[NSMutableArray alloc] initWithArray:loadedTasks];
    loadedTasks = [userDefaults arrayForKey:@"completedTasks"];
    self.completedTasks = [[NSMutableArray alloc] initWithArray:loadedTasks];
    
}

#pragma mark - Private
- (void)save{
    // Storing data from array and synchronize direct
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.tasks forKey:@"tasks"];
    [userDefaults setObject:self.completedTasks forKey:@"completedTasks"];
    [userDefaults synchronize];
}

# pragma mark - TableviewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
    {
        return [self.tasks count];
    }
    else
    {
        return [self.completedTasks count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.textLabel.text = self.tasks[indexPath.row];
        cell.textLabel.textColor = [UIColor colorWithRed:0.133 green:0.45 blue:0.788 alpha:1];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        
    } else {
        cell.textLabel.text = self.completedTasks[indexPath.row];
        cell.textLabel.textColor = [UIColor colorWithRed:0.658 green:0.784 blue:0.909 alpha:1];
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.957 green:0.957 blue:0.965 alpha:1];
    }
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
    
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)mainPath {
    [tableView deselectRowAtIndexPath:mainPath animated:YES];
    [tableView beginUpdates];
    tableView.delegate = self;
    
    [tableView deleteRowsAtIndexPaths:@[mainPath] withRowAnimation:UITableViewRowAnimationFade];
    
    if (mainPath.section == 0) {
        NSString *task = self.tasks[mainPath.row];
        [self.tasks removeObjectAtIndex:mainPath.row];
        [self.completedTasks insertObject:task atIndex:0];
        [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    else {
        NSString *task = self.completedTasks[mainPath.row];
        [self.completedTasks removeObjectAtIndex:mainPath.row];
        [self.tasks insertObject:task atIndex:0];
        [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    }
    [tableView endUpdates];
    
    [self save];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)mainPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (mainPath.section == 0) {
            [self.tasks removeObjectAtIndex:mainPath.row];
            [tableView deleteRowsAtIndexPaths:@[mainPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        else {
            [self.completedTasks removeObjectAtIndex:mainPath.row];
            [tableView deleteRowsAtIndexPaths:@[mainPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}



#pragma mark - TextFieldDelegate

//Make content from inputfield show up in table
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self.tasks insertObject:textField.text atIndex:0];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    textField.text = nil;
    
    
    [self save];
    
    return NO;
}

#pragma mark - User Actions

- (void)didTapShareButton {
    OCTListActivityItemSource *source = [[OCTListActivityItemSource alloc] initWithTasks:_tasks completedTasks:_completedTasks];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[source] applicationActivities:NULL];
    [self presentViewController:activityViewController animated:YES completion:NULL];
    [self.refreshControl endRefreshing];
    
}

// Shake Event
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.type == UIEventSubtypeMotionShake)
    {
        UIAlertView *warningMessage = [[UIAlertView alloc] initWithTitle:@"Clear List"
                                                                 message:@"You did a lot didn't you?"
                                                                delegate:self
                                                       cancelButtonTitle:@"Not really"
                                                       otherButtonTitles:nil];
        [warningMessage addButtonWithTitle:@"Yeah!"];
        [warningMessage show];
    }
}

// AlertView for Shake event
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    [super viewDidLoad];
    
    if([title isEqualToString:@"Yeah!"])
    {
        [self.completedTasks removeAllObjects];
        [[NSUserDefaults standardUserDefaults]arrayForKey:@"completedTasks"];
        [self.tableView reloadData];
    }
    
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)didShakeForTextField:(OCTTextField *)textField
{
    UIAlertView *warningMessage = [[UIAlertView alloc] initWithTitle:@"Clear List"
                                                             message:@"You did a lot didn't you?"
                                                            delegate:self
                                                   cancelButtonTitle:@"Not really"
                                                   otherButtonTitles:nil];
    [warningMessage addButtonWithTitle:@"Yeah!"];
    [warningMessage show];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [_addTask endEditing:YES];

}

@end