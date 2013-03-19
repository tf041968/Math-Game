//
//  HighScoreItem.h
//  Labb01
//
//  Created by Johan Persson on 2012-06-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HighScoreItem : NSManagedObject

@property (nonatomic, retain) NSNumber * time;

@end
