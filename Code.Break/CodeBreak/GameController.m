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
    
    background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"iphone_bg.jpg"] ];
    [[self view] setBackgroundColor:background];
    [background release];
    
    //RETRIEVE MESSAGE AND ENCRYPT - CREATE CRYPTOGRAM
    cryptogramPuzzle = [Cryptogram cryptoMessageWithNumber:messageNumber];
    [cryptogramPuzzle setEncryptionKeys];
    
    //SET INITIAL KEY ANSWERS TO AN EMPTY STRING
    answerKeys = [[NSMutableDictionary alloc] init];
    for (NSString *c in [cryptogramPuzzle.characterSet allValues]) {
        [answerKeys setValue:@"" forKey:c];
    }
    
    //DISPLAY ALL VIEWS
    [self displayDecryptionKeyScrollView];
    [self displayCryptogram];
    [self displayCharacterSelection];
}

- (void)setMessageNumber:(int) n
{
    messageNumber = n;
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
- (void)displayDecryptionKeyScrollView
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

        DisplayKeys *dk = [[DisplayKeys alloc] init];
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
        
        //[displayedKey release];
        //[answerButton release];
    }
    
    [decryptionKeyScrollView setContentSize:CGSizeMake(decryptionKeyScrollView.bounds.size.width -10, offset_y)];
    
    // add view for the player's answers in scroll view
    [decryptionKeyScrollView addSubview:answersView];
    
    // display answer section
    [[self view] addSubview:decryptionKeyScrollView];
}

-(void) displayCryptogram
{
    NSMutableDictionary *charSet = [cryptogramPuzzle characterSet];
    
    NSString *message = [cryptogramPuzzle cryptogram];
    int message_length = [message length];

    float offset_x = 20;
    float offset_y = 50;
    
    for(int i = 0; i < message_length; i++)
    {
        NSString *c = [NSString stringWithFormat:@"%c",[message characterAtIndex:i]];
        //print encryption for letters
        if([cryptogramPuzzle characterIsLetter:c])
        {
            UILabel *charLabel = [[UILabel alloc] initWithFrame:CGRectMake(offset_x, offset_y, 15, 15)];
            [charLabel setBackgroundColor:[UIColor clearColor]];
            [charLabel setText:[charSet valueForKey:c]];
            
            CryptoCharacter *aChar = [[CryptoCharacter alloc] initWithFrame:CGRectMake(offset_x, offset_y+20, 15, 15)];
            [aChar setText:@""];
            
            [[displayKeys objectForKey:[charSet valueForKey:c]] addCryptoCharacter:aChar];
            [displayCryptogramView addSubview:charLabel];
            [displayCryptogramView addSubview:aChar];
        }
        else //print character as it is
        {
            UILabel *charLabel = [[UILabel alloc] initWithFrame:CGRectMake(offset_x, offset_y, 15, 15)];
            [charLabel setBackgroundColor:[UIColor clearColor]];
            [charLabel setText:c];
            
            CryptoCharacter *aChar = [[CryptoCharacter alloc] initWithFrame:CGRectMake(offset_x, offset_y+20, 15, 15)];
            [aChar setText:c];
            
            [displayCryptogramView addSubview:charLabel];
            [displayCryptogramView addSubview:aChar];
        }
        
        offset_x += 20;
        
        if(offset_x >= 350)//displayCryptogram.bounds.size.width)
        {
            offset_x = 20;
            offset_y += 50;
        }
    }
}


- (void)displayCharacterSelection
{
    //Create the view for the selection of letters 
    characterSelection = [[UIScrollView alloc]
                          initWithFrame:
                          CGRectMake(0, displayCryptogramView.bounds.size.height-50.0f, self.view.bounds.size.width, 100.0f)];
    characterSelection.delegate = self;
    
    float charSelectionButtonDim = 50.0;
    CGFloat stringWidth = 50.0;
    NSInteger xOffset = 0;
    NSString *character;
    
    //for characters A - Z
    //ASCII of A = 65; Z = 90
    for (int i = 65; i <= 90; i++ )
    {
        character = [NSString stringWithFormat:@"%c", i];
        
        KeySelectionButton *tagButton = [[KeySelectionButton alloc] init];
        tagButton.frame = CGRectMake(xOffset, 0, charSelectionButtonDim, charSelectionButtonDim);
        
        [tagButton setKeyCharacter:character];
        
        [tagButton setTitle:character forState:UIControlStateNormal];
        [tagButton setTitle:character forState:UIControlStateHighlighted];
        [tagButton setTitle:character forState:UIControlStateSelected];
        [tagButton setTitle:character forState:UIControlStateDisabled];
        
        [tagButton addTarget:self action:@selector(answerKeySelected:) forControlEvents:UIControlEventTouchUpInside];
        
        //add button to dictionary
        [keyChoices setValue:tagButton forKey:character];
        
        //add the button to the scroll view
        [characterSelection addSubview:tagButton];
        
        xOffset += stringWidth;
    }
    
    //the view is initially hidden
    [characterSelection setHidden:YES];
    [characterSelection setContentSize:CGSizeMake(xOffset, 44.0f)];

    [[self view] addSubview:characterSelection];
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
        selectedAnswerKey.answer = sender.titleLabel.text;
        NSLog(@"Answer: %@ = %@", selectedAnswerKey.answerForKey, selectedAnswerKey.answer);

        [answerKeys setValue:selectedAnswerKey.answer forKey:selectedAnswerKey.answerForKey];
        
        
        //[selectedScrollViewKey setEnabled:NO];
        
        [[displayKeys objectForKey:selectedAnswerKey.answerForKey] changeCharacterDisplay:selectedAnswerKey.answer];
    
        [selectedAnswerKey setTitle:sender.titleLabel.text forState:UIControlStateNormal];
        [self disableUsedKeys];
    }
    
    if ([self checkAnswers])
        [self cryptogramSolved];
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

- (IBAction)backMenu:(UIButton *)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
/*    MenuController *menuController = [[MenuController alloc]init];
    menuController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [menuController presentedViewController];
    [self presentViewController:menuController animated:YES completion:nil];
    [menuController release];*/
}

- (BOOL)checkAnswers
{
    //answerKeys SHOULD be equal to cryptogram
    BOOL bWinFlag = YES;
    
    NSMutableDictionary *cryptogramAnswers = [[NSMutableDictionary alloc] init];
    for(NSString *s in [[cryptogramPuzzle characterSet] allKeys])
    {
        [cryptogramAnswers setValue:s forKey:[[cryptogramPuzzle characterSet] objectForKey:s]];
    }
    
    for(NSString *key in [answerKeys allKeys])
    {
        if(![[answerKeys objectForKey:key] isEqualToString:[cryptogramAnswers objectForKey:key]])
        {
            NSLog(@"WRONG! %@ != %@", key, [answerKeys objectForKey:key]);
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
    [defaults setInteger:seconds_elapsed forKey:cryptoNumber];
    
    NSString *winStr = [NSString stringWithFormat:@"%@win", cryptoNumber];
    [defaults setBool:game_status forKey:winStr];
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
   
- (void)dealloc {
    [self setCryptogramPuzzle:nil];
    [cryptogramPuzzle release];
    
    [keyChoices release];
    [answerKeys release];
    [displayKeys release];
    
    [displayCryptogramView release];
    [characterSelection release];
    [decryptionKeyScrollView release];
    
    [super dealloc];
}

- (void)viewDidUnload {
    [super viewDidUnload];

    [self setCryptogramPuzzle:nil];
    [cryptogramPuzzle release];
    
    [keyChoices release];
    [answerKeys release];
    [displayKeys release];
    
    [displayCryptogramView release];
    [characterSelection release];
    [decryptionKeyScrollView release];
}

@end
