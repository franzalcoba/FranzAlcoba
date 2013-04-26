//
//  MenuOption.h
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/22/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    This button is used in the menu page
    for selecting a puzzle.
 */

@interface MenuOption : UIButton

- (void)setAsSolved:(int)game_mode_finished;

@end
