//
//  AudioPlayer.m
//  Labb01
//
//  Created by Johan Persson on 2012-06-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AudioPlayer.h"

@implementation AudioPlayer 
@synthesize setVolume;
static AudioPlayer *audioPlayerClass = nil;


+(AudioPlayer*)audioPlayerClass{
    
    if (!audioPlayerClass) {
        audioPlayerClass = [[super allocWithZone:NULL] init];
    }
    return audioPlayerClass;
}

+(id)allocWithZone:(NSZone *)zone{
    
    return [self audioPlayerClass];
}

-(id)init{
    if (audioPlayerClass)
        return audioPlayerClass;
    self =[super init];
    setVolume = 0.5;
    return self;
}






-(void)playMusic{ 
    NSString *Soundclip = [[NSBundle mainBundle] pathForResource:@"music" ofType:@"mp3"];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:Soundclip] error:NULL];
    audioPlayer.volume = setVolume;
    audioPlayer.numberOfLoops = -1;
    [audioPlayer play];   
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
	
	if (flag) {
		NSLog(@"Did finish playing");
	} else {
		NSLog(@"Did NOT finish playing");
	}
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
	
	NSLog(@"%@", [error description]);
}


-(void)stopMusic{

    [audioPlayer stop];

}

-(void)setVolume: (double)currentVolume{
    setVolume = currentVolume;
    audioPlayer.volume = currentVolume;

}

@end
