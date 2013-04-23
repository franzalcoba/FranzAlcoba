//
//  Cryptogram.m
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/22/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "Cryptogram.h"

@implementation Cryptogram
@synthesize characterSet;

+(instancetype)cryptoMessageWithNumber:(int)index
{
    // find .plist file
    NSString* fileName = @"messages.plist";
    NSString* messagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    
    // load .plist file
    NSDictionary* cryptoDict = [NSDictionary dictionaryWithContentsOfFile:messagePath];
    
    // validation
    NSAssert(cryptoDict, @"level config file not found");
    
    // create Cryptogram instance
    // add autorelease
    Cryptogram* crypto = [[[Cryptogram alloc] init] autorelease];
    crypto.author = cryptoDict[@"cryptograms"][index][0];
    crypto.cryptogram = cryptoDict[@"cryptograms"][index][1];
    
    return crypto;
}

-(void) setEncryptionKeys
{
    keyCharacters = [[NSMutableArray alloc] init];
    for (int i = 65; i <= 90; i++) {
        [keyCharacters addObject:[NSString stringWithFormat:@"%c", i]];
    }

    NSLog(@"%@", [self cryptogram]);
    characterSet = [[NSMutableDictionary alloc] init];
    
    //Generate a key value for each character in the message string
    NSString *message = [self cryptogram];
    int message_length = [message length];
    
    for(int i = 0; i < message_length; i++)
    {
        NSString *c = [NSString stringWithFormat:@"%c",[message characterAtIndex:i]];
        
        //check if char is already in the dictionary
        //if DOES NOT yet exist, generate value
        if(![characterSet objectForKey:c] && [self characterIsLetter:c])
        {
            NSString *generatedKeyValue = [self generateKeyValue];
            [characterSet setValue:generatedKeyValue forKey:c];
            NSLog(@"%@ = %@", c, generatedKeyValue);
        }
    }    
}

- (NSString *) generateKeyValue
{
    int randomNum = random() % [keyCharacters count];
    NSString *generatedKey = [keyCharacters objectAtIndex:randomNum];
    [keyCharacters removeObject:generatedKey];
    return generatedKey;
}

- (BOOL)characterIsLetter: (NSString *) aChar
{
    int x = (int)[aChar characterAtIndex:0] ;
    return (x >= 65 && x <= 90);
}

@end
