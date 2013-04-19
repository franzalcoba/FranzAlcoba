//
//  CharacterList.m
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/11/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "CharacterList.h"

@implementation CharacterList

+(CharacterList *)sharedStore
{
    static CharacterList *sharedStore = nil;
    if(!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    
    return sharedStore;
}

+(id)initAllocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

-(id)init
{
    self = [super init];
    if(self)
    {
        allCharacters = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSArray *) allCharacters
{
    return allCharacters;
}

-(Character *)createCharacter
{
    Character *ch = [Character randomChar];
    [allCharacters addObject:ch];
    return ch;
}

-(void)removeItem:(Character *)ch
{
    [allCharacters removeObjectIdenticalTo:ch];
}

-(void)moveItemAtIndex:(int)from toIndex:(int)to
{
    if(from == to)
        return;
    
    Character *ch = [allCharacters objectAtIndex:from];
    
    [allCharacters removeObjectAtIndex:from];
    [allCharacters insertObject:ch atIndex:to];
}

@end
