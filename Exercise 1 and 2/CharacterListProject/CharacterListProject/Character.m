//
//  Character.m
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/11/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "Character.h"

@implementation Character

@synthesize charName, IDNumber, dateAdded, imageKey, job;
@synthesize statStrength, statConcentration, statDexterity, statIntelligence;

+ (id)randomStat:(Character *)ch
{
    [ch setStatStrength: (rand() % 100)];
    [ch setStatDexterity:(rand() % 100)];
    [ch setStatIntelligence: (rand() % 100)];
    [ch setStatConcentration: (rand() % 100)];
    
    return ch;
}

+(id)randomChar
{
    NSArray *randomAdjectiveList = [NSArray arrayWithObjects:@"Elwyn",@"Rusty",@"Raven", @"Devin", @"Zac", nil];
    NSArray *randomNounList = [NSArray arrayWithObjects:@"Reed",@"Amber",@"Stone", nil];
    
    NSInteger adjectiveIndex = rand() % [randomAdjectiveList count];
    NSInteger nounIndex = rand() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@", [randomAdjectiveList objectAtIndex:adjectiveIndex], [randomNounList objectAtIndex:nounIndex]];
    
    NSString *randomIDNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10];
    
    Character *newChar = [[self alloc] initWithCharName:randomName
                                               IDNumber:randomIDNumber];
    
    newChar = [self randomStat:newChar];
    return newChar;
}

-(id)initWithCharName:(NSString *)name
             IDNumber:(NSString *)sNumber
{
    self = [super init];
    
    if (self){
        [self setCharName:name];
        [self setJob:@"Novice"];
        [self setIDNumber:sNumber];
        dateAdded = [[NSDate alloc] init];
    }
    
    return self;
}

//overiding instance
-(NSString *)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@ (%@) - %@", charName, IDNumber, job];
    return descriptionString;
}

-(void)dealloc
{
    NSLog(@"Destroyed: %@",self);
}

@end
