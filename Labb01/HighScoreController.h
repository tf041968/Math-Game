//
//  HighScoreController.h
//  Labb01
//
//  Created by Johan Persson on 2012-06-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScore.h"

@interface HighScoreController : UIViewController <UITableViewDataSource, UITableViewDelegate>{

    NSArray *highScoreList;
    HighScore *highScore;
    NSManagedObject *entry;
    NSArray *sortedArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;




@end
