//
//  Logik.h
//  Labb01
//
//  Created by Johan Persson on 2012-05-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Logik : NSObject{
@private int randomNumber;
@private int totalAddedSum;
@private int numberOfButtonsChecked;

}



-(NSString*)setNumberToAddTo:(int)numberInterval addedNumber:(int)addedValue;

-(void)addToSum: (NSString *)buttonValue;
-(void)removeFromSum: (NSString *)buttonValue;
-(BOOL)checkIfTotalAddedSumIsAddedUp;
-(void)resetSum;
@end
