//
//  DisplayKeys.m
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/23/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "DisplayKeys.h"
#import "CryptoCharacter.h"

@implementation DisplayKeys

- (id)init
{
    self = [super init];
    
    if(self)
    {
        displayLabels = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addCryptoCharacter: (CryptoCharacter *)aChar
{
    [displayLabels addObject:aChar];
}

- (void)changeCharacterDisplay:(NSString *)newKey
{
    for (CryptoCharacter *cryptoChar in displayLabels) {
        [cryptoChar setText:newKey];
    }
}

- (NSString *)description
{
    NSString *todisplay = [[[NSString alloc] init] autorelease];
    for (CryptoCharacter *cryptoChar in displayLabels) {
        [todisplay stringByAppendingString:[NSString stringWithFormat:@"%@ ", cryptoChar.text]];
    }
    return todisplay;
}

- (void)dealloc
{
    displayLabels = nil;
    [displayLabels release];
    [super dealloc];
}

@end
