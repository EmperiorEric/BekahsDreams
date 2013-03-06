//
//  Dream.h
//  Bekahs Dreams
//
//  Created by Ryan Poolos on 3/5/13.
//  Copyright (c) 2013 Frozen Fire Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Dream : NSManagedObject

@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * archived;

@end
