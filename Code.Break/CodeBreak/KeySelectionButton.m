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
        UIImage *btn = [UIImage imageNamed:@"black_button.png"];
        [self setBackgroundImage:btn forState:UIControlStateNormal];
        //self.backgroundColor = [UIColor lightGrayColor];
        
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:24.0f];
        
        [self setKeyCharacter:@" "];
        /*
        [self setTitle:character forState:UIControlStateNormal];
        [self setTitle:character forState:UIControlStateHighlighted];
        [self setTitle:character forState:UIControlStateSelected];
        [self setTitle:character forState:UIControlStateDisabled];*/
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
