//
//  HighScore.h
//  Labb01
//
//  Created by Johan Persson on 2012-05-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HighScoreItem.h"
#import "HSEntry.h"

@interface HighScore : NSObject 
{
    @private
    double highScore;
    double currentTime;
    NSArray *highScoreList;
    NSMutableArray *highScoreArr;
    HSEntry *hsEntry;
    NSManagedObject *entry;
    NSArray *sortedArray;
}

@property double highScore;
@property NSString *doubleHighScoreToString;
@property (strong, nonatomic) NSMutableArray *highScoreArr;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(NSString*)setHighScoreTime:(double)tid;
//-(NSString*)PrintHighScoreTime;

-(NSString *)getHighscore;
+(HighScore*)hsClass;
-(double)getFirstPosition;

@end
