//
//  HighScore.h
//  MemoryGame
//
//  Created by Peter Leonard on 6/1/15.
//  Copyright (c) 2015 Peter Leonard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HighScore : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * score;

-(NSComparisonResult)compareScore:(HighScore *)otherObject;

@end
