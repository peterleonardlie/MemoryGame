//
//  Game4x4ViewController.h
//  MemoryGame
//
//  Created by Peter Leonard on 6/1/15.
//  Copyright (c) 2015 Peter Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
extern NSString* nameStringGlobal;

@interface Game4x4ViewController : UIViewController <AVAudioPlayerDelegate,UIApplicationDelegate>{
    bool twoDimensionalArray[3][3];
    int randomNo;
    bool truefalse;
    int buttonNo;
    NSString *buttonName;
    int score;
    int pressCount;
    bool running;
    int trueCount;
    NSTimer *countdownTimer;
    float time;
    NSTimer *gameTimer;
    float gameTime;
    float timeInterval;
    int highScore;
    UIImage *img;
    SystemSoundID correctID;
    AVAudioPlayer* correctSound;
    SystemSoundID wrongID;
    AVAudioPlayer* wrongSound;
}

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) NSString *nameString;

@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameTimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *scorelabel;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;

@end
