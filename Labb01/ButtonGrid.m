//
//  ButtonGrid.m
//  Labb01
//
//  Created by Johan Persson on 2012-06-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ButtonGrid.h"
#import "Button.h"

@implementation ButtonGrid


//Skapar rutnät med knappar. Tar emot antal knappar som ska finnas. 
-(NSMutableArray*)createGrid:(int) numberOfButtons{
    Button *myButton = [[Button alloc]init]; //Initierar en instans av en knapp. 
    UIButton *button; //Referenes till ett objekt. 
    NSMutableArray *arrayOfButtons = [[NSMutableArray alloc]init];//En tom array med knappar
    int col = 52; //Kolumnbredd
    int row = 150; //Radhöjd
    
    //Array innehållande knapparnas koordinater. 
    NSMutableArray *indexArray = [NSMutableArray arrayWithObjects:
                                  [NSValue valueWithCGPoint:CGPointMake(col, row)], 
                                  [NSValue valueWithCGPoint:CGPointMake(col, row*1.5)], 
                                  [NSValue valueWithCGPoint:CGPointMake(col, row*2)], 
                                  [NSValue valueWithCGPoint:CGPointMake(col*3, row)], 
                                  [NSValue valueWithCGPoint:CGPointMake(col*3, row*1.5)], 
                                  [NSValue valueWithCGPoint:CGPointMake(col*3, row*2)], 
                                  [NSValue valueWithCGPoint:CGPointMake(col*5, row)], 
                                  [NSValue valueWithCGPoint:CGPointMake(col*5, row*1.5)], 
                                  [NSValue valueWithCGPoint:CGPointMake(col*5, row*2)], nil];
    
    
    //Blandar om i arrayen.
    NSUInteger count = [indexArray count];
    for (NSUInteger i = 0; i < count; ++i) {
        int numberOfButtons = count - i;
        int randomNumberGiven = (arc4random() % numberOfButtons) + i;//Slumpar nummer
        [indexArray exchangeObjectAtIndex:i withObjectAtIndex:randomNumberGiven];//Byter plats i arrayen. 
    }   
    
    //Går ingenon arrayen
    for (int i = 0; i < numberOfButtons; i++) {
        button = [myButton createButton:i]; //Skappar en knapp
        button.center = [((NSValue *)[indexArray objectAtIndex:i]) CGPointValue]; //Position i GUI:t
        [arrayOfButtons addObject:button];//Lägger till knappen till arrayen. 
    }    
    return arrayOfButtons; //Returnerar en array med alla knappar inkl. nummer och position. 
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
