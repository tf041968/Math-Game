//
//  HighScoreController.m
//  Labb01
//
//  Created by Johan Persson on 2012-06-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HighScoreController.h"
#import "HighScore.h"
#import "AppDelegate.h"
@interface HighScoreController ()

@end

@implementation HighScoreController

@synthesize managedObjectContext;
@synthesize tableView;


#pragma mark - Table View
////TableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    entry = [sortedArray objectAtIndex:indexPath.row]; //Hämtar entry för vad rad
    double time = [[entry valueForKey:@"time"]doubleValue];//Sparar entry.time som double. För att kunna formatera. 
    NSString *timeString = [NSString stringWithFormat:@"%.2f", time]; //Formaterar double till 2 decimaler. 
    cell.textLabel.text = [NSString stringWithFormat:@"Plats: %d - %@",[indexPath row]+1,timeString]; //Skriver ut double i cell. 
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return sortedArray.count; //Lika många antal rader som arrayen håller HS.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Händer inget när man klickar på raden. 
}


#pragma mark - Core Data
//Laddar sparad data
-(void)onLoad{
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"HighScoreItem" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    NSError *error;
    highScoreList = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if(highScoreList == nil){
        NSLog(@"error %@", error);
        
    }
    
    if ([highScoreList count] == 0) {
        NSLog(@"Ingen sparad data");
    }
}

//Sparar data. 
- (void)saveContext
{
    NSError *error = nil;
    //    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Sort Array
//Sorterar array
-(void)sortArray{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time"
                                                 ascending:YES]; //Sorterar efter time och lägst först
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];//Skapar array som med regler för sort. 
    sortedArray = [highScoreList sortedArrayUsingDescriptors:sortDescriptors];//Array som sparar sorterad HSL.
}

#pragma mark - Empty HSL
//Tömmer HSL
- (IBAction)clearHighScores:(id)sender {
    
    for (int i = 0; i < sortedArray.count; i++) //För varje objekt i sorterad arr.
    {
        entry = [sortedArray objectAtIndex:i]; //Hämtar objekt på samma position som i. 
        [self.managedObjectContext deleteObject:entry]; //Tar bort objektet
        [self saveContext]; //Sparar on nya datan. 
    }
    highScore = [HighScore hsClass];
    highScore.highScore = 0; //Sätter highscore till 0
    [tableView reloadData]; //Laddar om data. 
}

#pragma mark - Dismiss View
//Knapp som stänger vyn
- (IBAction)backButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark - On Load Functions. 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //Når inte managedobject annars.  
    self.managedObjectContext = delegate.managedObjectContext;
    highScore = [HighScore alloc];
    highScoreList = [[NSMutableArray alloc]init];
    [self onLoad];
    [self sortArray];
    [tableView reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
