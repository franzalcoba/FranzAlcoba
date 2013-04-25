//
//  MenuOption.m
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/22/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "MenuOption.h"
#import "GameController.h"
#import "MenuController.h"

@implementation MenuOption

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Set button image
        UIImage *btn = [UIImage imageNamed:@"play.png"];
        [self setBackgroundImage:btn forState:UIControlStateNormal];
        [btn release];
        
        //Set button size
        frame.size = CGSizeMake(50.0, 50.0);
    }
    return self;
}

- (void)setAsSolved:(BOOL) won
{
    if(won){
        UIImage *btn = [UIImage imageNamed:@"message_unlocked.png"];
        [self setBackgroundImage:btn forState:UIControlStateNormal];
        [btn release];

        [self setTintColor:[UIColor greenColor]];
    }
    return;
}

 /*
- (void)startGamewithController:(MenuController *) menuController
{
    int gameNumber = [self buttonNumber];
    GameController *gameController =  [[GameController alloc] init];
    [gameController setMessageNumber:gameNumber];
    
    [menuController presentedViewController] ;
    //[[self navigationController] pushViewController:gameController animated:NO];
}
*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) dealloc
{
    [super dealloc];
}
@end
