//
//  CryptoCharacter.m
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/23/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "CryptoCharacter.h"

@implementation CryptoCharacter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[self setFont:]
        [self setTextColor:[UIColor redColor]];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
