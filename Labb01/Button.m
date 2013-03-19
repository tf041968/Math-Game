//
//  Button.m
//  Labb01
//
//  Created by Johan Persson on 2012-06-01.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Button.h"
#import "Logik.h"
#import "ButtonGrid.h"

@implementation Button



//Tar emot en siffra och skapar en knapp med denna siffra. 
-(UIButton*)createButton: (int)buttonNumber{
    
    UIImage *imgWhite = [UIImage imageNamed:@"bgWhite.png"]; //Sökväg till bild
    buttonNumber = buttonNumber + 1;//Lägger till 1 i index för att slippa nollan.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect]; //Skapar knapp
    button.tag = buttonNumber; //Sätter tag på knappen. 
    NSString *assignedNumber = [NSString stringWithFormat:@"%d",buttonNumber]; //Formaterar om till sträng. 
    [button setTitle:assignedNumber forState:UIControlStateNormal]; //Ger knappen sin siffra
    
    [button setBackgroundImage:imgWhite forState:UIControlStateNormal]; //Sätter bakgrund
    
    [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0.0, 0.0, 50.0, 40.0); //Knappstorlek
    
    return button; //Returnerar knapp inkl, siffra
    
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
