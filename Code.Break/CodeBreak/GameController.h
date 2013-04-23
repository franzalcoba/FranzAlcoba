//
//  GameController.h
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/22/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameController : UIViewController <UIScrollViewDelegate>
{
    IBOutlet UIView *displayCryptogram;
}
@property int messageNumber;
@property (retain, nonatomic) IBOutlet UIScrollView *characterSelection;
@property (retain, nonatomic) IBOutlet UIScrollView *decryption;

- (void) displayCryptogram;
- (void)setUpCharacterSelection;

@end
