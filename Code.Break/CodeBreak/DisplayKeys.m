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

- (void)changeCharacterDisplay:(NSString *)newKey isCorrect:(BOOL)validation
{
    for (CryptoCharacter *cryptoChar in displayLabels) {
        [cryptoChar setText:newKey];
        if(validation)
        {
            [cryptoChar setTextColor:[UIColor blueColor]];
        }
        else
        {
            [cryptoChar setTextColor:[UIColor redColor]];
        }
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
