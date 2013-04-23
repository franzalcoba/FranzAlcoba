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
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *cryptogram;
@property (strong, nonatomic) NSMutableDictionary *characterSet;

//factory method to load a .plist file and initialize the model
+(instancetype)cryptoMessageWithNumber:(int) index;
- (void) setEncryptionKeys;
- (NSString *) generateKeyValue;
- (BOOL)characterIsLetter: (NSString *) aChar;
@end
