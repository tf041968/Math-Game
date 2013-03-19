//
//  Timer.m
//  Labb01
//
//  Created by Johan Persson on 2012-05-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Timer.h"
#import "HighScore.h"
@implementation Timer
@synthesize timeString;
@synthesize timer = _timer;
@synthesize tidtagare;

-(id)init
{
    if (self = [super init])
    {
        // Initialization code here
    }
    return self;
}


//Startar tidtagningen
-(void)startTime{
    
    start = [NSDate date]; //Tid för start
    //Uppdaterar löpande tiden. 
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                             target:self
                                           selector:@selector(updateTimer)
                                           userInfo:nil
                                            repeats:YES];    
}

//Stoppar tidtagningen
-(void)stopTime{
    
    end = [NSDate date]; //Tid för stopp
    [timer invalidate]; //Stäng timer
    timer = nil; 
    
}

//Tid som gått åt. 
-(double)elapsedTime{
    //Tidsintervall som spelaren klarat spelet på. 
    NSTimeInterval elapsedTime = [end timeIntervalSinceDate:start]; 
    
    return elapsedTime;
    
}

//Uppdaterar tiden kontinuerligt. 
-(void)updateTimer {
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:start];
    timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"m:ss.S"];
    timeString =[dateFormatter stringFromDate:timerDate];
}



@end
