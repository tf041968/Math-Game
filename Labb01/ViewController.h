//
//  ViewController.h
//  Labb01
//
//  Created by Johan Persson on 2012-05-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController : UIViewController <AVAudioPlayerDelegate>
{
    NSString *currentHighScoreString;
    double currentHighScoreTime;
    UILabel *tickingClockLabel;
    UIButton *startButtonPressed;
    NSMutableArray *buttonArray;
    AVAudioPlayer *audioPlayer;
   
    
}
- (IBAction)startButtonPressed:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *tickingClockLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@property UIButton *startButtonPressed;
@property (weak, nonatomic) IBOutlet UILabel *summa;


@end
