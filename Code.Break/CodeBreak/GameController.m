//
//  GameController.m
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/22/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "GameController.h"
#import "Cryptogram.h"
#import "CryptoCharacter.h"
#import "EncryptionKey.h"
#import "AnswerKey.h"
#import "KeySelectionButton.h"
#import "DisplayKeys.h"
#import "MenuController.h"

@interface GameController ()
{
    int seconds_elapsed;
}
@end

@implementation GameController

@synthesize cryptogramPuzzle;
@synthesize displayCryptogramView, characterSelection, decryptionKeyScrollView;
@synthesize game_timer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    seconds_elapsed = 0;
    game_status = NO;
    
    [self fetchSavedData];
    
    //LOAD TIMER
    if(!game_status)
    {
        aTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(updateTimer:)
                                            userInfo:nil
                                             repeats:YES];
        [self updateTimer:aTimer];
    }else{
        [self cryptogramSolved];
    }
    
    //INSTANTIATE CONTAINERS
    displayKeys = [[NSMutableDictionary alloc] init];
    selectedAnswerKey = [[AnswerKey alloc] init];
    keyChoices = [[NSMutableDictionary alloc] initWithCapacity:26];
    
    //LOAD BACKGROUND
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"game_bg.jpg"] ];
    [displayCryptogramView setBackgroundColor:background];
    [background release];
    
    background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"buttons_bg.png"] ];
    [[self view] setBackgroundColor:background];
    [background release];
    
    
    UIImage *btnImage = [UIImage imageNamed:@"menu button.png"];

    UIButton *levelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    if (game_mode == 0) {
        [levelBtn setTitle:@"EASY" forState:UIControlStateDisabled];
    }else{
        [levelBtn setTitle:@"NORMAL" forState:UIControlStateDisabled];
    }
    [levelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [levelBtn setBackgroundImage:btnImage forState:UIControlStateDisabled];
    [levelBtn setEnabled:NO];
    btnImage = nil;

    levelBtn.frame = CGRectMake(110.0, -7.0, 150.0, 38.0);
    [displayCryptogramView addSubview:levelBtn];

    
    //RETRIEVE MESSAGE AND ENCRYPT - CREATE CRYPTOGRAM
    cryptogramPuzzle = [[Cryptogram alloc] initWithCryptoNumber:messageNumber]; //[Cryptogram cryptoMessageWithNumber:messageNumber];
    [cryptogramPuzzle setEncryptionKeys];
    
    //SET INITIAL KEY ANSWERS TO AN EMPTY STRING
    answerKeys = [[NSMutableDictionary alloc] init];
    for (NSString *c in [cryptogramPuzzle.characterSet allValues]) {
        [answerKeys setValue:@"" forKey:c];
    }
    
    //DISPLAY ALL VIEWS
    [self displayDecryptionKeys];
    [self displayCryptogram];
    [self displayCharacterSelection];
}

- (void)setMessageNumber:(int) n
{
    messageNumber = n;
}

- (void)setGameMode: (int) gameMode
{
    game_mode = gameMode;
}

- (void)updateTimer:(NSTimer *) theTimer
{
    int hours = 0;
    int minutes = seconds_elapsed / 60;
    int seconds = seconds_elapsed % 60;
    
    if(minutes > 60)
    {
        hours = minutes / 60;
        minutes = minutes % 60;
    }
    
    [game_timer setText:[NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds]];
    seconds_elapsed++;
}

// DISPLAY VIEW for PLAYER'S DECRYPTION KEY ANSWER
- (void)displayDecryptionKeys
{
    //SETUP SCROLL VIEW
    float scrollViewWidth = 103.0;
    float scrollViewHeight = displayCryptogramView.bounds.size.height;
    
    decryptionKeyScrollView = [[UIScrollView alloc]
                               initWithFrame:
                               CGRectMake(displayCryptogramView.bounds.size.width,
                                          0, scrollViewWidth, scrollViewHeight)];
    decryptionKeyScrollView.delegate = self;

    // SETUP VIEW CONTAINER for PLAYER's ANSWERS
    const float answerButtonSize = 35.0;
    
    float answerViewWidth = decryptionKeyScrollView.bounds.size.width-10;
    float answerViewHeight = (answerButtonSize+10) * [answerKeys count];
    UIView *answersView = [[UIView alloc] initWithFrame:CGRectMake(3,5, answerViewWidth, answerViewHeight+10)];
    
    float offset_x = 10;
    float offset_y = 10;
    
    // CREATE BUTTONS for THE CRYPTOGRAM KEYS
    NSArray *sortedKeys = [[answerKeys allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    
    for(NSString *c in sortedKeys)
    {
        DisplayKeys *dk = [[[DisplayKeys alloc] init] autorelease];
        [displayKeys setValue:dk forKey:c];
        
        EncryptionKey *displayedKey = [[EncryptionKey alloc] initWithFrame:CGRectMake(offset_x, offset_y, answerButtonSize, answerButtonSize)];
        [displayedKey setTitle:c forState:UIControlStateNormal];
        
        offset_x += answerButtonSize+10;
        
        AnswerKey *answerButton = [[AnswerKey alloc] initWithFrame:CGRectMake(offset_x, offset_y, answerButtonSize, answerButtonSize)];
        [answerButton addTarget:self action:@selector(answerKeySelect:) forControlEvents:UIControlEventTouchUpInside];
        [answerButton setAnswerForKey:c];
        
        // add encryption character and decryption character buttons
        // to player's answers view
        [answersView addSubview:displayedKey];
        [answersView addSubview:answerButton];
        
        offset_x = 10;
        offset_y += answerButtonSize + 5;
        
        [displayedKey release];
        [answerButton release];
    }
    
    [decryptionKeyScrollView setContentSize:CGSizeMake(decryptionKeyScrollView.bounds.size.width -10, offset_y)];
    
    // add view for the player's answers in scroll view
    [decryptionKeyScrollView addSubview:answersView];
    
    // display answer section
    [[self view] addSubview:decryptionKeyScrollView];
    [answersView release];
}

-(void) displayCryptogram
{
    NSMutableDictionary *charSet = [cryptogramPuzzle characterSet];
    
    NSString *message = [cryptogramPuzzle cryptogram];
    int message_length = [message length];

    float offset_x = 20;
    float offset_y = 10;
    
    //SETUP VIEW CONTAINERS
    UIScrollView *displayCryptoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,30, displayCryptogramView.bounds.size.width, displayCryptogramView.bounds.size.height)];
    
    UIView *cryptogramView = [[UIView alloc] initWithFrame:CGRectMake(0,0, displayCryptogramView.bounds.size.width, displayCryptogramView.bounds.size.height)];

    const int maxChars = 14;
    
    //create an array of words
    NSMutableArray *wordsArray = [[NSMutableArray alloc] init];
    NSString *aWord = [[NSString alloc] init];
    for(int i = 0; i < message_length; i++)
    {
        if(!([message characterAtIndex:i] == 32)){
            aWord = [NSString stringWithFormat:@"%@%c", aWord, [message characterAtIndex:i]];
        }else{
            [wordsArray addObject: aWord];
            aWord = @"";
            continue;
        }
        
        if(i == message_length-1){
            [wordsArray addObject: aWord];
            aWord = nil;
        }
    }
    [aWord release];
    
    int word_length = 0;
    int charsLeft = maxChars;
    
    //PRINT WORDS one by one
    for (int j = 0; j < [wordsArray count]; j++) {
        //number of characters in the word
        word_length = [[wordsArray objectAtIndex:j] length]; 
        
        //Word exceeds the screen, go to NEXT LINE
        if(charsLeft < word_length){
            charsLeft = maxChars; //reset characters left
            offset_x = 20;
            offset_y += 50;
        }
        
        //Word fits on screen, PRINT WORD per character
        if(word_length <= charsLeft){
            for(int k = 0; k < word_length; k++)
            {
                NSString *c = [NSString stringWithFormat:@"%c",[[wordsArray objectAtIndex:j] characterAtIndex:k]];
                if([cryptogramPuzzle characterIsLetter:c])
                {
                    
                    //CRYPTOGRAM ANSWER
                    CryptoCharacter *aChar = [[CryptoCharacter alloc] initWithFrame:CGRectMake(offset_x, offset_y, 20, 15)];
                    [aChar setText:@""];
                    [cryptogramView addSubview:aChar];
                    
                    //add to array
                    [[displayKeys objectForKey:[charSet valueForKey:c]] addCryptoCharacter:aChar];
                    [aChar release];
                    
                    //CRYPTOGRAM LABEL
                    UILabel *charLabel = [[UILabel alloc] initWithFrame:CGRectMake(offset_x, offset_y+15, 20, 15)];
                    [charLabel setBackgroundColor:[UIColor clearColor]];
                    [charLabel setText:[charSet valueForKey:c]];
                    [cryptogramView addSubview:charLabel];
                    [charLabel release];
                    
                    
                }
                else //print character as it is
                {
                    //CRYPTOGRAM ANSWER
                    CryptoCharacter *aChar = [[CryptoCharacter alloc] initWithFrame:CGRectMake(offset_x, offset_y, 20, 15)];
                    [aChar setText:c];
                    [cryptogramView addSubview:aChar];
                    [aChar release];
                    
                    //CRYPTOGRAM LABEL
                    UILabel *charLabel = [[UILabel alloc] initWithFrame:CGRectMake(offset_x, offset_y+15, 20, 15)];
                    [charLabel setBackgroundColor:[UIColor clearColor]];
                    [charLabel setText:c];
                    [cryptogramView addSubview:charLabel];
                    [charLabel release];
                }
                offset_x += 20;
            }//end printing of a word
            
            //PRINT SPACE after every word.
            
            
            
            //CRYPTOGRAM ANSWER
            CryptoCharacter *aChar = [[CryptoCharacter alloc] initWithFrame:CGRectMake(offset_x, offset_y, 20, 15)];
            [aChar setText:@" "];
            [cryptogramView addSubview:aChar];
            [aChar release];
            
            //CRYPTOGRAM LABEL
            UILabel *charLabel = [[UILabel alloc] initWithFrame:CGRectMake(offset_x, offset_y+15, 20, 15)];
            [charLabel setBackgroundColor:[UIColor clearColor]];
            [charLabel setText:@" "];
            [cryptogramView addSubview:charLabel];
            [charLabel release];
            
            offset_x += 20;
            
            charsLeft -= word_length;
            NSLog(@"%@ : %d", [wordsArray objectAtIndex:j], charsLeft);
        }
    }
    [wordsArray release];
    
    [displayCryptoScrollView setContentSize:CGSizeMake(decryptionKeyScrollView.bounds.size.width, offset_y + 100)];
    [displayCryptoScrollView addSubview:cryptogramView];
    
    [displayCryptogramView addSubview:displayCryptoScrollView];
    
    [cryptogramView release];
    [displayCryptoScrollView release];
}

- (void)displayCharacterSelection
{
    //Create the view for the selection of letters
    characterSelection = [[UIScrollView alloc]
                          initWithFrame:
                          CGRectMake(0, displayCryptogramView.bounds.size.height-100.0f, self.view.bounds.size.width, 100.0f)];
    characterSelection.delegate = self;
    
    float charSelectionButtonDim = 65.0;
    CGFloat stringWidth = 65.0;
    NSInteger xOffset = 0;
    NSString *character;
    
    //for characters A - Z
    //ASCII of A = 65; Z = 90
    for (int i = 65; i <= 90; i++ )
    {
        character = [NSString stringWithFormat:@"%c", i];
        
        KeySelectionButton *tagButton = [[KeySelectionButton alloc] init];
        tagButton.frame = CGRectMake(xOffset, 18, charSelectionButtonDim, charSelectionButtonDim);
        
        [tagButton setKeyCharacter:character];
        
        [tagButton setTitle:character forState:UIControlStateNormal];
        [tagButton setTitle:character forState:UIControlStateHighlighted];
        [tagButton setTitle:character forState:UIControlStateSelected];
        [tagButton setTitle:character forState:UIControlStateDisabled];
        
        [tagButton addTarget:self action:@selector(answerKeySelected:) forControlEvents:UIControlEventTouchUpInside];
        
        //add button to dictionary
        [keyChoices setValue:tagButton forKey:character];
        
        //add the button to the scroll view
        [characterSelection addSubview:[keyChoices objectForKey:character]];
        
        [tagButton release];
        
        xOffset += stringWidth;
    }
    
    //the view is initially hidden
    [characterSelection setHidden:YES];
    
    UIColor *keysBG = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"keyboard-bg.png"] ];
    [characterSelection setBackgroundColor:keysBG];
    [characterSelection setContentSize:CGSizeMake(xOffset, 44.0f)];
    [[self view] addSubview:characterSelection];
    
    [keysBG release];
}

- (void)answerKeySelect: (AnswerKey *)sender
{
    selectedAnswerKey = sender;
    [characterSelection setHidden:NO];
}

- (void)answerKeySelected: (KeySelectionButton *)sender
{
    selectedScrollViewKey = sender;

    if(sender.isEnabled){
        [selectedAnswerKey setBackgroundImage:nil forState:UIControlStateNormal];
        UIImage *btn = [UIImage imageNamed:@"correct.png"];
        [selectedAnswerKey setBackgroundImage:btn forState:UIControlStateNormal];

        selectedAnswerKey.answer = sender.titleLabel.text;
        NSLog(@"Answer: %@ = %@", selectedAnswerKey.answerForKey, selectedAnswerKey.answer);

        [answerKeys setValue:selectedAnswerKey.answer forKey:selectedAnswerKey.answerForKey];
  
        [[displayKeys objectForKey:selectedAnswerKey.answerForKey] changeCharacterDisplay:selectedAnswerKey.answer];
    
        [selectedAnswerKey setTitle:sender.titleLabel.text forState:UIControlStateNormal];
        [self disableUsedKeys];
    }
    
    if ([self checkAnswers])
    {
        [self cryptogramSolved];
    }
}

- (void) disableUsedKeys
{
    if(keyChoices)
    {
        for(KeySelectionButton *k in keyChoices)
        {
            //NSLog(@"hello");
        //
        //[k setEnabled:YES];
        //NSLog(@"KeySelection label: %@", [k keyCharacter]);
        /*if(tLabel)
        {
            if([[answerKeys allValues] containsObject:tLabel])
            {
                [k setEnabled:NO];
            }
        }*/
        //tLabel = nil;
        }
    }
    [characterSelection setHidden:YES];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        seconds_elapsed = 0;
        game_status = NO;
        [self save:nil];
        [[self navigationController] popViewControllerAnimated:NO];
    }
}

- (IBAction)backMenu:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Puzzle not yet solved!"
                                                    message:@"Exiting the game will reset your development. Continue?"
                                                   delegate:self
                                          cancelButtonTitle:@"Continue Puzzle"
                                          otherButtonTitles:@"Exit",nil];
    [alert show];
    [alert release];
}

- (BOOL)checkAnswers
{
    //answerKeys SHOULD be equal to cryptogram
    BOOL bWinFlag = YES;

    //reverse player answers
    NSMutableDictionary *cryptogramAnswers = [[NSMutableDictionary alloc] init];
    for(NSString *s in [[cryptogramPuzzle characterSet] allKeys])
    {
        [cryptogramAnswers setValue:s forKey:[[cryptogramPuzzle characterSet] objectForKey:s]];
    }

    for(NSString *key in [answerKeys allKeys])
    {
        if(![[answerKeys objectForKey:key] isEqualToString:[cryptogramAnswers objectForKey:key]])
        {
            if(game_mode == 0)
            {
                //recently selected answer button change to RED if wrong
                if([selectedAnswerKey.answer isEqualToString:[answerKeys objectForKey:key]])
                {
                    [selectedAnswerKey setBackgroundImage:nil forState:UIControlStateNormal];
                    UIImage *btn = [UIImage imageNamed:@"wrong.png"];
                    [selectedAnswerKey setBackgroundImage:btn forState:UIControlStateNormal];
                }
                //NSLog(@"WRONG! %@ != %@", key, [answerKeys objectForKey:key]);
            }
            bWinFlag = NO;
        }
    }

    [cryptogramAnswers release];
    return bWinFlag;
}

- (void)cryptogramSolved
{
    //stop time
    [aTimer invalidate];
    aTimer = nil;
    
    //temporary
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"GREAT JOB!"
                                                      message:@"You've decoded the secret message."
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    game_status = YES;
    [self save:nil];
    [self backMenu:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender
{
    NSString *cryptoNumber = [NSString stringWithFormat:@"%d", messageNumber];
    
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *winStr = [NSString stringWithFormat:@"%@win", cryptoNumber];
    NSString *gameMode = [NSString stringWithFormat:@"%@mode", cryptoNumber];
    
    //STORE TIME ELAPSED FOR GAME
    [defaults setInteger:seconds_elapsed forKey:cryptoNumber];
    
    //STORE GAME STATUS - win or not finished
    [defaults setBool:game_status forKey:winStr];
    
    //STORE GAME MODE - easy or normal
    [defaults setInteger:game_mode forKey:gameMode];
    
    [defaults synchronize];
    NSLog(@"Data saved");
}

-(void)fetchSavedData
{
    NSString *cryptoNumber = [NSString stringWithFormat:@"%d", messageNumber];
    NSString *winStr = [NSString stringWithFormat:@"%@win", cryptoNumber];
    
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    seconds_elapsed = [defaults integerForKey:cryptoNumber];
    game_status = [defaults boolForKey:winStr];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    [cryptogramPuzzle dealloc];
    keyChoices = nil;
    answerKeys = nil;
    displayKeys = nil;
    
    displayCryptogramView = nil;
    characterSelection = nil;
    decryptionKeyScrollView = nil;
    
}

- (void)dealloc {
    [cryptogramPuzzle release];
    
    [keyChoices release];
    [answerKeys release];
    [displayKeys release];
    
    [displayCryptogramView release];
    [characterSelection release];
    [decryptionKeyScrollView release];
    [super dealloc];
}

@end
