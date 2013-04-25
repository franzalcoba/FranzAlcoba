//
//  GameController.h
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/22/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cryptogram.h"
#import "AnswerKey.h"
#import "KeySelectionButton.h"

@interface GameController : UIViewController <UIScrollViewDelegate>
{
    NSTimer *aTimer;
    int messageNumber;
    BOOL game_status;
    
    // CRYPTOGRAM CHARACTERS
    // KEY  : letter (NSString)
    // VALUE: array of DisplayKeys (NSMutableArray)
    NSMutableDictionary *displayKeys;
    
    // PLAYER ANSWER KEYS
    // KEY  : letter (NSString)
    // VALUE: letter (NSString)
    NSMutableDictionary *answerKeys;
    
    // SELECTION KEYS
    // KEY  : letter (NSString)
    // VALUE: KeySelectionButton
    NSMutableDictionary *keyChoices;
    
    AnswerKey *selectedAnswerKey;
    KeySelectionButton *selectedScrollViewKey;
}

/****************************************************************************/

//SELECTED CRYPTOGRAM
@property (strong, nonatomic) Cryptogram *cryptogramPuzzle;

//MAIN VIEWS
@property (retain, nonatomic) IBOutlet UIView *displayCryptogramView;
@property (retain, nonatomic) IBOutlet UIScrollView *characterSelection;
@property (retain, nonatomic) IBOutlet UIScrollView *decryptionKeyScrollView;

//TIMER DISPLAY
@property (retain, nonatomic) IBOutlet UILabel *game_timer;

/****************************************************************************/

//PUZZLE NUMBER SELECTED
- (void)setMessageNumber:(int) n;

//DISPLAY OF MAIN VIEWS
- (void)displayCryptogram;
- (void)displayCharacterSelection;
- (void)displayDecryptionKeys;

//TIMER saving and loading
- (IBAction)save:(id)sender;
- (void)fetchSavedData;

//CHECK ANSWERS
- (BOOL)checkAnswers;
- (void)cryptogramSolved;

//ETC
- (IBAction)backMenu:(id)sender;
- (void)answerKeySelect: (AnswerKey *)sender;
- (void) disableUsedKeys;

@end
