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
        // Initialization code
        UIImage *btn = [UIImage imageNamed:@"lock.png"];
        [self setBackgroundImage:btn forState:UIControlStateNormal];
        
        CGSize btnSize = CGSizeMake(50.0, 50.0);
        frame.size = btnSize;
    }
    return self;
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
@end
