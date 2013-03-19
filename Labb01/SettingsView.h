//
//  SettingsView.h
//  Labb01
//
//  Created by Johan Persson on 2012-06-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsView : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *musicSwitch;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
- (IBAction)volumeChanged:(id)sender;

@end
