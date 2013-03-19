//
//  ButtonGrid.h
//  Labb01
//
//  Created by Johan Persson on 2012-06-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonGrid : UIButton{

int buttonsPerRow;  
}

-(NSMutableArray*)createGrid:(int)numberOfButtons;
@end
