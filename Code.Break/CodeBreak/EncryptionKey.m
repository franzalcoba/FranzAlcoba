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
        UIImage *btn = [UIImage imageNamed:@"black_button.png"];
        [self setBackgroundImage:btn forState:UIControlStateNormal];
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        // Set default backgrond color
        //[self setBackgroundColor:[UIColor blackColor]];
        // Add Custom Font
        //[[self titleLabel] setFont:[UIFont fontWithName:@"Knewave" size:18.0f]];
    }
    return self;
}
/*
- (void)setAnswerKey: (AnswerKey *)answerKey
{
    ansKey = answerKey;
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
