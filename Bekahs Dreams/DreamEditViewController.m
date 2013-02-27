//
//  DreamEditViewController.m
//  Bekahs Dreams
//
//  Created by Ryan Poolos on 2/26/13.
//  Copyright (c) 2013 Frozen Fire Studios. All rights reserved.
//

#import "DreamEditViewController.h"
#import "EditableCell.h"

@interface DreamEditViewController () <UITableViewDataSource, UITableViewDelegate>
{
    BOOL newDream;
    
    UINavigationBar *navBar;
    
    UITableView *table;
    
    NSString *title;
    NSString *notes;
}
@end

@implementation DreamEditViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // If we don't have a dream, we're making a new dream.
    newDream = (!self.dream);
    
    // navBar
    navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 44.0)];
    [navBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:navBar];
    
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:(newDream ? @"New Dream" : @"Edit Dream")];
    item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    item.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(finish)];
    [navBar pushNavigationItem:item animated:NO];
    
    // Setup Table
    table = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 44.0, self.view.frame.size.width, self.view.frame.size.height - 44.0) style:UITableViewStyleGrouped];
    [table setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [table setDataSource:self];
    [table setDelegate:self];
    [self.view addSubview:table];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)finish
{
    // create dream
    if (newDream) {
        self.dream = [[DataManager sharedManager] addDreamWithTitle:@"" andNotes:@""];
    }
    
    // save
    [[DataManager sharedManager] saveContext];
    
    // dismiss
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate didEditDream:self.dream];
    }];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section) {
        return 320.0;
    } else {
        return 44.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[EditableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if (indexPath.section == 0) {
        [cell.textField setPlaceholder:@"Title"];
        
        if (!newDream) {
            [cell.textField setText:self.dream.title];
        }
    } else {
        [cell.textField setPlaceholder:@"Notes"];
        
        if (!newDream) {
            [cell.textField setText:self.dream.notes];
        }
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
