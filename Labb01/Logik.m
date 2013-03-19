//
//  Logik.m
//  Labb01
//
//  Created by Johan Persson on 2012-05-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Logik.h"
@interface Logik()
@property int randomNumber;
@property int totalAddedSum;
@property int numberOfButtonsChecked;
@end



@implementation Logik
@synthesize randomNumber;
@synthesize totalAddedSum;
@synthesize numberOfButtonsChecked;



//Randomgenerator för slutsumma och knapparnas siffror. 
-(NSString*)setNumberToAddTo: (int)numberInterval addedNumber:(int)addedValue{
    randomNumber = (arc4random() %numberInterval ) +addedValue;
    randomNumber = randomNumber + 1; //För att man inte ska få siffran 0
    NSString *formattedRandomNumber = [NSString stringWithFormat:@"%d",randomNumber];
    return formattedRandomNumber;
}

//Lägger till vald siffra till summan
-(void)addToSum: (NSString *)buttonValue{
    int buttonValueInt = [buttonValue intValue];
    totalAddedSum += buttonValueInt;
    numberOfButtonsChecked++;
}

//tar bort vald siffra från summan.
-(void)removeFromSum: (NSString *)buttonValue{
    int buttonValueInt = [buttonValue intValue];
    totalAddedSum -= buttonValueInt;
    numberOfButtonsChecked--;
}

//Återställer summan
-(void)resetSum{
    numberOfButtonsChecked = 0;
    totalAddedSum = 0;
}

//Kollar om spelet är klart, summorna är lika. 
-(BOOL)checkIfTotalAddedSumIsAddedUp{
    
    if ((totalAddedSum == randomNumber) && (numberOfButtonsChecked == 3)) {
        return TRUE;
    }
    else {
        return FALSE;
    }
    
}

@end
