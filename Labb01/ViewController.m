//
//  ViewController.m
//  Labb01
//
//  Created by Johan Persson on 2012-05-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Timer.h"
#import "HighScore.h"
#import "Logik.h"
#import "Button.h"
#import "ButtonGrid.h"
#import "HighScoreController.h"
#import "SettingsView.h"
#import "AudioPlayer.h"

@interface ViewController ()
{   
    UIImage *imgBlue;
    UIImage *imgWhite;
    UIImage *imgBg;
    bool gameIsRunning;
    AudioPlayer *myPlayer;
}
@property (nonatomic, strong) Timer *timer;
@property (nonatomic, strong) HighScore *highScore;
@property (nonatomic, strong) Logik *logik;
@property (nonatomic, strong) Button *button;
@property (nonatomic, strong) ButtonGrid *buttonGrid;
@property (weak, nonatomic) IBOutlet UIButton *startButtonOutlet;
@end

@implementation ViewController
@synthesize tickingClockLabel;
@synthesize highScoreLabel;
@synthesize summa;

@synthesize buttonGrid = _buttonGrid;
@synthesize startButtonOutlet;
@synthesize startButtonPressed = _startButtonPressed;

@synthesize timer = _timer;
@synthesize highScore = _highScore;
@synthesize logik = _logik;
@synthesize button = _button;

#pragma mark - Class instansiations
//Skapar instanser av de olika klasserna. 
-(Timer *)timer{
    if(!_timer)_timer = [[Timer alloc]init];
    return _timer;
}

-(HighScore *)highScore{
    if(!_highScore) _highScore = [[HighScore alloc]init];
    return _highScore;
}

-(Logik *)logik{
    if(!_logik) _logik = [[Logik alloc]init];
    return _logik;
}

-(Button *)button{
    if(!_button) _button = [[Button alloc]init];
    return _button;
}
-(ButtonGrid *)buttonGrid{
    if(!_buttonGrid) _buttonGrid = [[ButtonGrid alloc]init];
    return _buttonGrid;
}

#pragma mark - Button Functions
//Körs när man klickar på en sifferruta. 
- (IBAction)buttonWithNumbers:(UIButton*)sender {
    
    if (gameIsRunning) //Körs om spelet är startat
    {
        NSString *buttonValue = [sender currentTitle]; //Värdet på knappen man trycker på. 
        
        //Körs om knappen inte är intryckt/aktiv. 
        if(sender.selected == FALSE) 
        {
            //Lägger till valda värdet i en sträng.
            [self.logik addToSum:buttonValue]; 
            
            //Körs om man klarat spelet. 
            if ([self.logik checkIfTotalAddedSumIsAddedUp])
            {
                [self.timer stopTime]; //Stoppar klockan.
                [self gameIsCompleted];
                
            }
            //Om man inte klarat spelet så markeras rutan.
            [sender setBackgroundImage:imgBlue forState:UIControlStateNormal];
            [sender setSelected:TRUE];
            
        }
        
        //Körs om knappen redan är aktiv/intryckt. 
        else {
            //Avmarkerar rutan och tar bort värdet från totalsumman. 
            [sender setBackgroundImage:imgWhite forState:UIControlStateNormal];
            [self.logik removeFromSum:buttonValue];
            //Kollar om man klarar spelet genom att avmarkera en ruta. 
            if([self.logik checkIfTotalAddedSumIsAddedUp])
            {
                [self gameIsCompleted];   
            }
            [sender setSelected:FALSE];
        }
        
    }
    
}

//Körs när man trycker på startknappen. 
- (IBAction)startButtonPressed:(UIButton *)sender {
    
    //Om spelet inte körs   
    if(!gameIsRunning){
        
        int sumInterval = 19; //Sätter intervall på summan som ska gissas. 
        int addedValue=5; //Lägger till på intervallet för att slippa låga nummer. 
        
        [self createGrid]; //Skapar nya knappar
        [self.logik resetSum]; //Återställer räknare till startläge. 
        [self.timer startTime]; //Startar tidtagning
        [self updateTimer]; //Uppdaterar tidtagningen
        
        [startButtonOutlet setTitle:@"Stopp!" forState:UIControlStateNormal];
        gameIsRunning = YES; //Ställer bool så att spelet är i körning.
        //Skriver ut summan som man ska samla ihop till. 
        summa.text = [self.logik setNumberToAddTo:sumInterval addedNumber:addedValue];           
    }
    
    //Om spelet körs. 
    else {
        [self.timer stopTime]; //Klockan stannas
        [startButtonOutlet setTitle:@"Start" forState:UIControlStateNormal]; //Ändrar text på knapp
        [self.logik resetSum];//Ställer gissade summan på noll
        gameIsRunning = NO; //Spelet är inaktivt. 
    }
}

//Highscoreknapp
- (IBAction)highScoreButton:(id)sender {
    HighScoreController *hsContr = [[HighScoreController alloc]initWithNibName:@"HighScoreController" bundle:nil];
    [self presentModalViewController:hsContr animated:YES];
}

//Settingsknapp
- (IBAction)settingsButton:(id)sender {
    SettingsView *settingsView = [[SettingsView alloc]initWithNibName:@"SettingsView" bundle:nil];
    [self presentModalViewController:settingsView animated:YES];
}

#pragma mark - Game Is Completed
//Körs när man klarat spelet
-(void)gameIsCompleted{
    [startButtonOutlet setTitle:@"Start!" forState:UIControlStateNormal];//Ändrar text på startknapp
    [self setHighscore]; //Kör metod för att jämföra highscore. 
    [self PrintHighScore]; //Kör metod för att skriva ut highscore. 
    gameIsRunning = false;
}

#pragma mark - Audio Functions
-(void)playMusic{ 
    NSString *Soundclip = [[NSBundle mainBundle] pathForResource:@"music" ofType:@"mp3"];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:Soundclip] error:NULL];
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

#pragma mark - Update Functions
//Metod som startat uppdateringen av labels som visar tid löpande. 
-(void)updateTimer{
    
    [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                     target:self
                                   selector:@selector(updateTimerString)
                                   userInfo:nil
                                    repeats:YES]; 
    
}
//Uppdaterar klockan löpande. 
-(void)updateTimerString{
    tickingClockLabel.text = self.timer.timeString;
}

#pragma mark - HighScore Functions
//Kollar och sätter Highscore
-(void)setHighscore{
    [self getHsTime];
    [self.highScore setHighScoreTime:[self.timer elapsedTime]];
    currentHighScoreTime = self.highScore.highScore;
}

//Skriver ut Highscore i GUI:t
-(void)PrintHighScore{
    
    //self.highScoreLabel.text = self.highScore.PrintHighScoreTime;
    self.highScoreLabel.text = self.highScore.getHighscore;
}
//Hämtar första position i HSL
-(void)getHsTime{
currentHighScoreTime = [self.highScore getFirstPosition];
}

#pragma mark - Create Grid
//Skapar spelplan
-(void)createGrid{
    buttonArray = [self.buttonGrid createGrid:9]; //Skapar array med knappar
    
    //Loopar knapparna 
    for (int i = 0; i < buttonArray.count; i++) {
        
        UIButton *button = [buttonArray objectAtIndex:i]; //Skapar knapp från array.    
        [button addTarget:self action:@selector(buttonWithNumbers:) 
         forControlEvents:UIControlEventTouchUpInside]; //Refererar till den metod som ska köras vid knapptryckning. 
        [self.view addSubview: button];//Ritar ut knappen
        
    }
}


#pragma mark - On Load Functions
-(void)viewWillAppear:(BOOL)animated{
    [self PrintHighScore];

}
- (void)viewDidLoad
{   myPlayer = [[AudioPlayer alloc]init];
    [myPlayer playMusic];
    imgBlue = [UIImage imageNamed:@"bgBlue.png"];
    imgWhite = [UIImage imageNamed:@"bgWhite.png"];
    imgBg = [UIImage imageNamed:@"appbg.png"];
    [super viewDidLoad];
    currentHighScoreTime = [self.highScore getFirstPosition];
    [self createGrid]; //Skapar rutnätet med knappar 
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidUnload
{
    [self setHighScoreLabel:nil];
    [self setSumma:nil];
    [self setStartButtonOutlet:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
