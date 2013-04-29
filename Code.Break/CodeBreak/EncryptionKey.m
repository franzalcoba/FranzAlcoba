//
//  EncryptionKey.m
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/23/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "EncryptionKey.h"

@implementation EncryptionKey

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [self setEnabled:NO];
    }
    return self;
}
@end
