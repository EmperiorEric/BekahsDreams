//
//  DreamEditViewController.h
//  Bekahs Dreams
//
//  Created by Ryan Poolos on 2/26/13.
//  Copyright (c) 2013 Frozen Fire Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dream.h"

@class DreamEditViewController;

@protocol DreamEditorDelegate <NSObject>

- (void)didEditDream:(Dream *)dream;

@end

@interface DreamEditViewController : UIViewController

@property (nonatomic, strong) id <DreamEditorDelegate> delegate;

@property (nonatomic, strong) Dream *dream;

@end
