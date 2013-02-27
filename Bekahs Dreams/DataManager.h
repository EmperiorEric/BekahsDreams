//
//  DataManager.h
//  Bekahs Dreams
//
//  Created by Ryan Poolos on 2/26/13.
//  Copyright (c) 2013 Frozen Fire Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Dream.h"

@interface DataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (readonly, strong, nonatomic) NSArray *dreams;

+ (DataManager *)sharedManager;

- (Dream *)addDreamWithTitle:(NSString *)title andNotes:(NSString *)notes;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
