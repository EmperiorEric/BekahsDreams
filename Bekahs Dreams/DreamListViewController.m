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
    NSArray *dreams;
}
@end

@implementation DreamListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
            
    // Setup the navigationItem
    self.title = @"Bekah's Dreams";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newDream:)];
    
    dreams = [[[DataManager sharedManager] dreams] copy];
    
    // Setup the Table
    table = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
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
    dreams = [[[DataManager sharedManager] dreams] copy];
    
    [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"rows: %i",dreams.count);
    return [dreams count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Dream *dream = [dreams objectAtIndex:indexPath.row];
    
    cell.textLabel.text = dream.title;
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Push Detail View
    DreamViewController *viewer = [[DreamViewController alloc] init];
    viewer.dream = [dreams objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:viewer animated:YES];
}

@end
