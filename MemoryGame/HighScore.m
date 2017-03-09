//
//  HighScore.m
//  MemoryGame
//
//  Created by Peter Leonard on 6/1/15.
//  Copyright (c) 2015 Peter Leonard. All rights reserved.
//

#import "HighScore.h"


@implementation HighScore

@dynamic name;
@dynamic score;

-(NSComparisonResult)compareScore:(HighScore *)otherObject{
    
    return [self.score compare:otherObject.score];
}

@end
