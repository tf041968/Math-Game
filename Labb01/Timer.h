//
//  Timer.h
//  Labb01
//
//  Created by Johan Persson on 2012-05-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timer : NSObject{
    NSDate *start;
    NSDate *end;
    NSDate *timerDate;
    NSTimer *timer;
    NSDate *test;
}

@property (retain, nonatomic) NSString *timeString;
@property (assign, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSString *tidtagare;

-(void) startTime;
-(void) stopTime;

-(double) elapsedTime;


@end
