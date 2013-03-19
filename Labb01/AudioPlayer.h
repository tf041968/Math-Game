//
//  AudioPlayer.h
//  Labb01
//
//  Created by Johan Persson on 2012-06-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AudioPlayer : AVAudioPlayer <AVAudioPlayerDelegate>
{
    double setVolume;
AVAudioPlayer *audioPlayer;
}

@property (nonatomic) double setVolume;

+(AudioPlayer*)audioPlayerClass;

-(void)playMusic;
-(void)stopMusic;
-(void)setVolume: (double)currentVolume;

@end
