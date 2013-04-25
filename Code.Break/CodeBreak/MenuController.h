//
//  MenuController.h
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/22/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuOption.h"

@interface MenuController : UIViewController
{
    
}

- (void)showPuzzleMenu;
- (IBAction)backToTitle: (UIButton *)sender;
- (IBAction)startGame: (MenuOption *)sender;
- (IBAction)showDecryptedMessage: (MenuOption *)sender;

@end
