//
//  DisplayKeys.h
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/23/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CryptoCharacter.h"

@interface DisplayKeys : NSObject
{
    NSMutableArray *displayLabels;
}
- (void)addCryptoCharacter: (CryptoCharacter *)aChar;
- (void)changeCharacterDisplay:(NSString *)newKey isCorrect:(BOOL)validation;

@end
