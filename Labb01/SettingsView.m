//
//  SettingsView.m
//  Labb01
//
//  Created by Johan Persson on 2012-06-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsView.h"
#import "AudioPlayer.h"

@interface SettingsView (){

    AudioPlayer *myPlayer;
    BOOL musicIsPlaying;
}

@end

@implementation SettingsView
@synthesize musicSwitch;
@synthesize volumeSlider;

#pragma mark - On Load Functions
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        myPlayer = [AudioPlayer audioPlayerClass];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setMusicSwitch:nil];
    [self setVolumeSlider:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Dismiss View
- (IBAction)backButton:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];

}

#pragma mark - Music Settings
- (IBAction)musicToggleButton:(id)sender {
    if(musicSwitch.on){
    [myPlayer playMusic];
        musicIsPlaying = YES;
    }
    else{
        [myPlayer stopMusic];
        musicIsPlaying = NO;
    }
}
- (IBAction)volumeChanged:(id)sender {
    
    NSLog(@"ändrat värde med %f", [volumeSlider value]);
    [myPlayer setVolume:[volumeSlider value]];
}
@end
