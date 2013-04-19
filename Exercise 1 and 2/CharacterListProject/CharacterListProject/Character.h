//
//  Character.h
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/11/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Character : NSObject

@property (nonatomic, copy) NSString *imageKey;
@property NSString *charName;
@property NSString *IDNumber;
@property NSString *job;

@property float statStrength;
@property float statDexterity;
@property float statConcentration;
@property float statIntelligence;

@property (nonatomic, readonly) NSDate *dateAdded;

+(id)randomChar;
+(id)randomStat:(Character *)ch;
-(id)initWithCharName:(NSString *)name IDNumber:(NSString *)sNumber;
     

@end
