//
//  KeySelectionButton.h
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/23/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    Customized button character for the player's selection of characters.
    Displayed at the bottom of the screen.
 */

@interface KeySelectionButton : UIButton
@property (strong, nonatomic) NSString *keyCharacter;
@end
