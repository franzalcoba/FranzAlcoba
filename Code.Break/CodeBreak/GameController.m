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

@interface GameController ()

@end

@implementation GameController
@synthesize messageNumber, characterSelection, decryption;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    
    return self;
}

-(void) displayCryptogram
{
    Cryptogram *crypto = [Cryptogram cryptoMessageWithNumber:messageNumber];
    
    [crypto setEncryptionKeys];
    
    NSMutableDictionary *charSet = [crypto characterSet];
    
    NSString *message = [crypto cryptogram];
    int message_length = [message length];
    
    
    NSMutableArray *cryptogramDisplay = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < message_length; i++)
    {
        NSString *c = [NSString stringWithFormat:@"%c",[message characterAtIndex:i]];
        //if character is a letter, print encrypted letter
        if([crypto characterIsLetter:c])
        {
            
        }
        //else print as is
        else
        {
            CryptoCharacter *aChar = [[CryptoCharacter alloc] init];
            [aChar setText:@"hello"];
            [displayCryptogram addSubview:aChar];
        }
    }

    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self displayCryptogram];
    
     UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"game_bg.jpg"] ];
    [displayCryptogram setBackgroundColor:background];
	// Do any additional setup after loading the view.
    
    [self setUpCharacterSelection];
    
}

- (void)setUpCharacterSelection
{
    NSMutableArray *dataBuilder = [[NSMutableArray alloc] initWithCapacity:26];
    for (int i = 65; i <= 90; i++ ) {
        [dataBuilder addObject:[NSString stringWithFormat:@"%c", i]];
    }
    
    characterSelection = [[UIScrollView alloc]
                          initWithFrame:
                          CGRectMake(0, self.view.bounds.size.height - 65, self.view.bounds.size.width, 150.0f)];
    characterSelection.delegate = self;
    
    NSInteger xOffset = 0;
    
    float charSelectionButtonDim = 50.0;
    
    for (NSString *character in dataBuilder) {
        UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        CGFloat stringWidth = 50.0;
        
        tagButton.frame = CGRectMake(xOffset, 0, charSelectionButtonDim, charSelectionButtonDim);
        tagButton.backgroundColor = [UIColor lightGrayColor];
        
        tagButton.titleLabel.textColor = [UIColor blackColor];
        tagButton.titleLabel.font = [UIFont systemFontOfSize:24.0f];
    
        [tagButton setTitle:character forState:UIControlStateNormal];
        [tagButton setTitle:character forState:UIControlStateHighlighted];
        [tagButton setTitle:character forState:UIControlStateSelected];
        [tagButton setTitle:character forState:UIControlStateDisabled];
        
        [characterSelection addSubview:tagButton];
        
        xOffset += stringWidth;
    }
    
    [characterSelection setContentSize:CGSizeMake(xOffset, 44.0f)];
    
    [[self view] addSubview:characterSelection];
    [dataBuilder release];
    [characterSelection release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [displayCryptogram release];
    [characterSelection release];
    [decryption release];
    [super dealloc];
}
@end
