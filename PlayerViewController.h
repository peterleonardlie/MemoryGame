//
//  PlayerViewController.h
//  MemoryGame
//
//  Created by Peter Leonard on 5/1/15.
//  Copyright (c) 2015 Peter Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
extern NSString *nameStringGlobal;

@interface PlayerViewController : UIViewController {
    
    NSString* nameString;
}

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end
