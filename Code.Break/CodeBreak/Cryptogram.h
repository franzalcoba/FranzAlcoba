//
//  Cryptogram.h
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/22/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cryptogram : NSObject
{
    NSMutableArray *keyCharacters;
}

//properties taken from .pList
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *cryptogram;

//dictionary containing the answer key assignment for the cryptogram
// KEY : VALUE
// KEY      = character from the message
// VALUE    = generated random character
@property (strong, nonatomic) NSMutableDictionary *characterSet;



//factory method to load a .plist file and initialize the model
//+(instancetype)cryptoMessageWithNumber:(int) index;
- (id) initWithCryptoNumber:(int)index;

//functions for message encryption
- (void) setEncryptionKeys;
- (NSString *) generateKeyValue;

//function for checking if a character is a letter
- (BOOL)characterIsLetter: (NSString *) aChar;
- (BOOL)characterIsSpace: (NSString *) aChar;

@end
