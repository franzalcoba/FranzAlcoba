//
//  CharacterList.h
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/11/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"

@interface CharacterList : NSObject
{
    NSMutableArray *allCharacters;
}
+ (CharacterList *) sharedStore;
- (NSArray *)allCharacters;
- (Character *)createCharacter;
- (void)removeItem:(Character *)ch;
- (void)moveItemAtIndex:(int)from toIndex:(int)to;

@end
