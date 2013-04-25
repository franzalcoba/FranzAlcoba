//
//  AnswerKey.m
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/23/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "AnswerKey.h"

@implementation AnswerKey
@synthesize answerForKey, answer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *btn = [UIImage imageNamed:@"black_button.png"];
        [self setBackgroundImage:btn forState:UIControlStateNormal];
        [self setTitle:@"?" forState:UIControlStateNormal];
        
        //[self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //[self setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        answerForKey = [[NSString alloc] init];
        answer = [[NSString alloc] init];
    }
    return self;
}

/*
// Only override drawRect: if you perfosrm custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
