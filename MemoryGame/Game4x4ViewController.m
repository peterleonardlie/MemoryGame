//
//  Game4x4ViewController.m
//  MemoryGame
//
//  Created by Peter Leonard on 6/1/15.
//  Copyright (c) 2015 Peter Leonard. All rights reserved.
//

#import "Game4x4ViewController.h"
#import "HighScore.h"
#import "AppDelegate.h"

@interface Game4x4ViewController ()

@end

@implementation Game4x4ViewController {
    
    AppDelegate* appDelegate;
}

@synthesize scorelabel,countdownLabel,gameTimerLabel,highScoreLabel,nameLabel,nameString;

-(void)timerRun{
    time = time -1;
    NSString *timerOutput = [NSString stringWithFormat:@"%.2f", time];
    countdownLabel.text = timerOutput;
    if (time == 0) {
        [countdownTimer invalidate];
        countdownTimer = nil;
        [self stop];
    }
}

-(void)gameTimerRun{
    gameTime = gameTime - 0.1;
    NSString *timerOutput = [NSString stringWithFormat:@"%.2f", gameTime];
    gameTimerLabel.text = timerOutput;
    buttonNo = 1;
    if (gameTime < 0.1){
        gameTime = 0;
        NSString *timerOutput = [NSString stringWithFormat:@"%.2f", gameTime];
        gameTimerLabel.text = timerOutput;
        for (int i = 0; i<16; i++){
            UIButton *temp1 = (UIButton *)[self.view viewWithTag:buttonNo];
            temp1.backgroundColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
            [temp1 setBackgroundImage:nil forState:UIControlStateNormal];
            temp1.enabled = YES;
            temp1.adjustsImageWhenDisabled = NO;
            buttonNo++;
            
        }
        [gameTimer invalidate];
        gameTimer = nil;
        
    }
    
    
    
}

-(void)setTimer {
    time = 60;
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
}

-(void)setGameTimer {
    if (timeInterval<1) {
        timeInterval = 1;
    }
    gameTime= timeInterval;
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(gameTimerRun) userInfo:nil repeats:YES];
}

-(void)imageSet{
    
}

-(void)startGame{
    buttonNo = 1;
    running = true;
    
    
    
    for (int i = 0; i<4; i++) {
        for (int j=0; j<4; j++) {
            randomNo = arc4random()%2;
            if (randomNo == 1){
                truefalse = true;
                NSString *inttostr = [NSString stringWithFormat:@"%d",buttonNo];
                NSString *button = @"button";
                buttonName = [NSString stringWithFormat:@"%@%@",button,inttostr];
                
                
            }else
                truefalse=false;
            twoDimensionalArray[i][j]= truefalse;
        }
        
    }
    buttonNo = 1;
    
    for (int x=0;x<4;x++){
        for(int y =0;y<4;y++){
            if(twoDimensionalArray[x][y]== true){
                UIButton *temp = (UIButton *)[self.view viewWithTag:buttonNo];
                
                temp.backgroundColor = [UIColor clearColor];
                [temp setBackgroundImage:img forState:UIControlStateNormal];
                [temp addTarget:self action:@selector(incrementScore:) forControlEvents:UIControlEventTouchUpInside];
                temp.adjustsImageWhenDisabled = NO;
                temp.enabled = NO;
                
                trueCount++;
            }
            else{
                UIButton *temp = (UIButton *)[self.view viewWithTag:buttonNo];
                [temp addTarget:self action:@selector(decrementScore:) forControlEvents:UIControlEventTouchUpInside];
                temp.enabled = NO;
                
            }
            buttonNo++;
        }
        
    }
    
    
    
}

-(void)reset{
    pressCount = 0;
    trueCount= 0;
    buttonNo = 1;
    for (int i = 0; i<16; i++){
        UIButton *temp1 = (UIButton *)[self.view viewWithTag:buttonNo];
        
        temp1.backgroundColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        [temp1 setBackgroundImage:nil forState:UIControlStateNormal];
        temp1.enabled = YES;
        [temp1 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [temp1 setTitle:@"" forState:UIControlStateNormal];
        
        buttonNo++;
    }
    
    running = false;
}

-(IBAction)incrementScore:(id)sender{
    score++;
    
    [correctSound play];
    
    NSString *inttostr = [NSString stringWithFormat:@"Score is: %d",score];
    self.scorelabel.text = inttostr;
    pressCount++;
    UIButton *buttonThatWasPressed = (UIButton *)sender;
    [sender setTitle:@"^_^" forState:UIControlStateNormal];
    buttonThatWasPressed.backgroundColor = [UIColor clearColor];
    [buttonThatWasPressed setBackgroundImage:img forState:UIControlStateNormal];
    buttonThatWasPressed.adjustsImageWhenDisabled = NO;
    buttonThatWasPressed.enabled = NO;
    
    if (pressCount == trueCount){
        timeInterval= timeInterval-0.5;
        time = time + 2;
        [self reset];
        [self setGameTimer];
        [self startGame];
    }
    
}
-(void)decrementScore:(id)sender{
    score--;
    [wrongSound play];
    NSString *inttostr = [NSString stringWithFormat:@"Score is:%d",score];
    self.scorelabel.text = inttostr;
    UIButton *buttonThatWasPressed = (UIButton *)sender;
    buttonThatWasPressed.backgroundColor = [UIColor redColor];
    buttonThatWasPressed.adjustsImageWhenDisabled = NO;
    buttonThatWasPressed.enabled = NO;
    
    if (pressCount == trueCount){
        [self reset];
        [self startGame];
        [gameTimer invalidate];
        gameTimer = nil;
    }
}

-(void)stop {
    [self reset];
    highScore = 0;
    if (score > highScore){
        
        NSNumber* scoreForHighScore = [NSNumber numberWithInt:score];
        highScore = score;
        
        HighScore* HighScore3x3Board = [NSEntityDescription insertNewObjectForEntityForName:@"HighScore" inManagedObjectContext:appDelegate.managedObjectContext];
        HighScore3x3Board.score = scoreForHighScore;
        HighScore3x3Board.name = nameStringGlobal;
        
        [appDelegate saveContext];
    }
    
    NSFetchRequest* request = [[NSFetchRequest alloc]
                               initWithEntityName:@"HighScore"];
    NSArray* highScore3x3Array = [appDelegate.managedObjectContext
                                  executeFetchRequest:request error:NULL];
    
    NSArray* sortedHighScore3x3 = [highScore3x3Array sortedArrayUsingSelector:@selector(compareScore:)];
    HighScore* my_score = sortedHighScore3x3.lastObject;
    
    highScore = [my_score.score intValue];
    NSString* scorerName = my_score.name;
    
    NSString *highScoretext = [NSString stringWithFormat:@"Highest Scorer: %@ Score: %d", scorerName, highScore];
    highScoreLabel.text = highScoretext;
    score = 0;
    self.scorelabel.text = @"Score";
    timeInterval = 5;
    time = 60;
    NSString *timerOutput = [NSString stringWithFormat:@"%.2f", time];
    countdownLabel.text = timerOutput;
    NSString *timerOutput1 = [NSString stringWithFormat:@"%.2f", timeInterval];
    gameTimerLabel.text = timerOutput1;
    [gameTimer invalidate];
    gameTimer = nil;
    [countdownTimer invalidate];
    countdownTimer = nil;
    
}




-(IBAction)start:(id)sender{
    timeInterval=5;
    [self setTimer];
    [self setGameTimer];
    [self startGame];
}

-(IBAction)resetGame:(id)sender{
    [self stop];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = [UIApplication sharedApplication].delegate;
    // Do any additional setup after loading the view.
    self.nameLabel.text = nameStringGlobal;
    buttonNo = 1;
    pressCount = 0;
    img = [UIImage imageNamed:@"orange.png"];
    NSString *correctURL = [[NSBundle mainBundle]pathForResource:@"beep" ofType:@"mp3"];
    correctSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:correctURL] error:NULL];
    NSString *wrongURL = [[NSBundle mainBundle]pathForResource:@"wrong" ofType:@"wav"];
    wrongSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:wrongURL] error:NULL];
    
    NSFetchRequest* request = [[NSFetchRequest alloc]
                               initWithEntityName:@"HighScore"];
    NSArray* highScore3x3Array = [appDelegate.managedObjectContext
                                  executeFetchRequest:request error:NULL];
    
    NSArray* sortedHighScore3x3 = [highScore3x3Array sortedArrayUsingSelector:@selector(compareScore:)];
    HighScore* my_score = sortedHighScore3x3.lastObject;
    
    highScore = [my_score.score intValue];
    NSString* scorerName = my_score.name;
    
    
    NSString *highScoretext = [NSString stringWithFormat:@"Highest Scorer: %@ Score: %d", scorerName, highScore];
    highScoreLabel.text = highScoretext;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)sd:(id)sender {
}
@end
