//
//  DreamListViewController.m
//  Bekahs Dreams
//
//  Created by Ryan Poolos on 2/26/13.
//  Copyright (c) 2013 Frozen Fire Studios. All rights reserved.
//

#import "DreamListViewController.h"
#import "DreamEditViewController.h"
#import "DreamViewController.h"

@interface DreamListViewController () <UITableViewDataSource, UITableViewDelegate, DreamEditorDelegate>
{
    UITableView *table;
    
    NSMutableArray *dreams;
    NSMutableArray *archivedDreams;
}
@end

@implementation DreamListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
            
    // Setup the navigationItem
    self.title = @"Bekah's Dreams";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newDream:)];
    
    dreams = [[[DataManager sharedManager] dreams] mutableCopy];
    archivedDreams = [[[DataManager sharedManager] archivedDreams] mutableCopy];
    
    // Setup the Table
    table = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    [table setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [table setDataSource:self];
    [table setDelegate:self];
    [self.view addSubview:table];
}

- (void)newDream:(id)sender
{
    // Present modal dream editor
    DreamEditViewController *editor = [[DreamEditViewController alloc] init];
    editor.delegate = self;
    
    [self presentViewController:editor animated:YES completion:^{
        //
    }];
}

#pragma mark - DreamEditor Delegate

- (void)didEditDream:(Dream *)dream
{
    dreams = [[[DataManager sharedManager] dreams] mutableCopy];
        
    [table reloadData];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [dreams count];
    } else {
        return [archivedDreams count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Dreams";
    } else {
        return @"Archived Dreams";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    Dream *dream;
    if (indexPath.section == 0) {
        dream = [dreams objectAtIndex:indexPath.row];
    } else {
        dream = [archivedDreams objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = dream.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return @"Archive";
    } else {
        return @"Delete";
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 0) {
            Dream *dream = [dreams objectAtIndex:indexPath.row];
            dream.archived = [NSNumber numberWithBool:YES];
            
            [archivedDreams addObject:dream];
            [dreams removeObject:dream];
            
            [[DataManager sharedManager] saveContext];
            
            [tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:(archivedDreams.count - 1) inSection:1]];
        } else {
            [[[DataManager sharedManager] managedObjectContext] deleteObject:[archivedDreams objectAtIndex:indexPath.row]];
            
            archivedDreams = [[[DataManager sharedManager] archivedDreams] mutableCopy];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        }
        
    }
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Push Detail View
//    DreamViewController *viewer = [[DreamViewController alloc] init];
//    viewer.dream = [dreams objectAtIndex:indexPath.row];
//
//    [self.navigationController pushViewController:viewer animated:YES];
    
    Dream *dream;
    if (indexPath.section == 0) {
        dream = [dreams objectAtIndex:indexPath.row];
    } else {
        dream = [archivedDreams objectAtIndex:indexPath.row];
    }
    
    DreamEditViewController *editor = [[DreamEditViewController alloc] init];
    editor.dream = dream;
    editor.delegate = self;
    
    [self presentViewController:editor animated:YES completion:^{
        //
    }];
}

@end
