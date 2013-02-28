//
//  DreamViewController.m
//  Bekahs Dreams
//
//  Created by Ryan Poolos on 2/26/13.
//  Copyright (c) 2013 Frozen Fire Studios. All rights reserved.
//

#import "DreamViewController.h"
#import "DreamEditViewController.h"

@interface DreamViewController () <DreamEditorDelegate>

@end

@implementation DreamViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.dream.title;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editDream)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)editDream
{
    // Present modal dream editor
    DreamEditViewController *editor = [[DreamEditViewController alloc] init];
    editor.delegate = self;
    editor.dream = self.dream;
    
    [self presentViewController:editor animated:YES completion:^{
        //
    }];
}

#pragma mark - Dream Editor Delegate

- (void)didEditDream:(Dream *)dream
{
    self.dream = dream;
}

@end
