//
//  HighScore.m
//  Labb01
//
//  Created by Johan Persson on 2012-05-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HighScore.h"
#import "HighScoreItem.h"
#import "AppDelegate.h"


@implementation HighScore;

static HighScore *hsClass = nil;

@synthesize highScore;
@synthesize doubleHighScoreToString;
@synthesize highScoreArr;

@synthesize managedObjectContext;


+(HighScore*)hsClass{
    
    if (!hsClass) {
        hsClass = [[super allocWithZone:NULL] init];
    }
    return hsClass;
}

+(id)allocWithZone:(NSZone *)zone{
    
    return [self hsClass];
}

-(id)init{
    if (hsClass)
        return hsClass;
    self =[super init];
    highScoreArr =[[NSMutableArray alloc]initWithCapacity:10];
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //Når inte managedobject annars.  
    self.managedObjectContext = delegate.managedObjectContext;
    hsEntry = [[HSEntry alloc]init];
    return self;
}



//Jämför spelarens tid med den befintliga highscorelistan. 
-(NSString*)setHighScoreTime: (double) tid{
    double currentHighScore = [self getFirstPosition]; //Hämtar första positionen i sorterad arr.
    hsEntry = [[HSEntry alloc]init]; //Allok & init av ett HighScore-entry
    if (currentHighScore == 0) //Om Highscorelistan är tom. 
    {
        hsEntry.time = [NSNumber numberWithDouble:tid]; //Sätt angiven tid som HS
        [self onSave]; //Spara
        [self alertBox]; //Visa grattismeddelande. 
        //highScore = [[hsEntry time]doubleValue];
    }
    else if (tid < currentHighScore) //Om tid är mindre än HS
    {
        hsEntry.time = [NSNumber numberWithDouble:tid]; //Sätt nytt HS med angiven tid
        [self onSave]; //Spara
        [self alertBox]; //Visa grattismeddelande
        //highScore = [[hsEntry time]doubleValue];
    }
    else //Om man inte slår position 1 i HSL 
    {
        hsEntry.time = [NSNumber numberWithDouble:tid]; //Sätt värde i entry
        [self onSave]; //Spara
    }
    //Formaterar och returnerar strängen. 
    doubleHighScoreToString = [NSString stringWithFormat:@"%f", highScore];
    return doubleHighScoreToString;
}


//Skriver ut highscore
-(NSString *)PrintHighScoreTime: (double)highScore{
    
    NSDate *highScoreTime = [NSDate dateWithTimeIntervalSince1970:highScore];//Date som inehåller intervall 
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //Formateringsfunktion.
    [dateFormatter setDateFormat:@"m:ss.S"]; //Formateringsfunktion
    NSString *timeString =[dateFormatter stringFromDate:highScoreTime]; //Formaterar sträng med tid. 
    return timeString; //Returnerar tid som sträng, formaterad och klar. 
    
}

//Alertruta när man fått nytt highscore
-(void)alertBox{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Grattis!" 
                          message:@"Du satte nytt Highscore." 
                          delegate:nil 
                          cancelButtonTitle:@"Stäng" 
                          otherButtonTitles: nil];
    [alert show];
    
}


//Sparar tid
-(void)onSave{
    
    NSManagedObject *item =[NSEntityDescription insertNewObjectForEntityForName:@"HighScoreItem" inManagedObjectContext:self.managedObjectContext]; //Sätter upp koppling till entity
    //Sparar tweetens olika värde i Core Data. 
    [item setValue:hsEntry.time forKey:@"time"];
    
    [self saveContext];
}

//Metod som körs för att spara tweets. Autogenererad. 
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

//Laddar sparade positioner
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

//Sorterar higscorelistan 
-(void)sortArray{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time"
                                                                   ascending:YES]; //Sorterar efter time och lägst först. 
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor]; //Skapar array som med regler för sort. 
    
    sortedArray = [highScoreList sortedArrayUsingDescriptors:sortDescriptors]; //Array som sparar sorterad HSL.
    [self removeNonHighScores];//TYar bort överflödiga HS
    
}

//Tar bort överflödiga HS
-(void)removeNonHighScores{
    if (sortedArray.count >= 11) //Om sorterad arr har fler än 10 objekt. 
    {
        for (int i = 10; sortedArray.count >= 11; i++)//För varje objekt över tio 
        {
            entry = [sortedArray objectAtIndex:i]; //Hämtar HS-entry för position i sorterad arr
            [self.managedObjectContext deleteObject:entry]; //Tar bort objekt. 
            [self saveContext]; //Sparar om 
            [self onLoad]; //Hämtar sparad HSL.
            [self sortArray]; //Sorterar nya HSL
        }
    }
}

//Hämtar HS
-(NSString *)getHighscore{
    [self onLoad]; //Hämtar HSL
    [self sortArray]; //Sorterar HSL
    
    if ((!sortedArray.count == 0)) //Om sorted arr innehåller objekt
    {
        hsEntry = [sortedArray objectAtIndex:0]; //Hämta första objektet. 
        double hsDouble =[[hsEntry time]doubleValue]; //Spara 1:a objektets tid i double
        return [self PrintHighScoreTime:hsDouble]; //Returnera resultatet av metod inkl tid i double.
    }
    return [NSString stringWithFormat:@"%f", 0]; //Returnerar 0 om sorted arr är tom. 
}

//Hämtar första position. 
-(double)getFirstPosition{
    
    [self onLoad]; //Hämtar sparad HSL
    [self sortArray]; //Sorterar HSL
    if (sortedArray.count == 0) //Om HSL har 0 objekt
    {
        return 0; //Returnerar 0
    }
    //Om HSL innehåller objekt. 
    hsEntry = [sortedArray objectAtIndex:0]; //Hämta första objektet. 
    
    return [[hsEntry time]doubleValue]; //Returnera första objektets tid som double. 
}

@end
