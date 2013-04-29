//
//  KeySelectionButton.m
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/23/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "KeySelectionButton.h"

@implementation KeySelectionButton
@synthesize keyCharacter;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *btn = [UIImage imageNamed:@"game_key_button.png"];
        [self setBackgroundImage:btn forState:UIControlStateNormal];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:24.0f];
        [self setKeyCharacter:@" "];
    }
    return self;
}

@end
