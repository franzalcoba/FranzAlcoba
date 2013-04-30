//
//  MenuController.m
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/22/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "MenuController.h"
#import "MenuOption.h"
#import "GameController.h"
#import "MessageSolvedViewController.h"

@interface MenuController ()
    
@end

@implementation MenuController

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
	// Do any additional setup after loading the view.
    UIImageView *backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [backGround setImage:[UIImage imageNamed:@"menu-bg.png"]];
    [backGround setAlpha:0.5];
    [[self view] addSubview:backGround];
    [[self view] sendSubviewToBack:backGround];
    [backGround release];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self
                   action:@selector(backToTitle:)
         forControlEvents:UIControlEventTouchDown];
    [backButton setImage:[UIImage imageNamed:@"back button 32.png"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(5.0, 5.0, 32.0, 32.0);
    [[self view] addSubview:backButton];
 
    UIButton *levelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (game_mode == 0) {
        [levelBtn setTitle:@"EASY GAME" forState:UIControlStateDisabled];
    }else{
        [levelBtn setTitle:@"NORMAL GAME" forState:UIControlStateDisabled];
    }
    [[levelBtn titleLabel] setFont:[UIFont fontWithName:@"Copperplate" size:20.f]];
    
    [levelBtn setBackgroundColor:[UIColor clearColor]];
    [levelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [levelBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [levelBtn setEnabled:NO];
    levelBtn.frame = CGRectMake(260.0, 0.0, 200.0, 38.0);
    [[self view] addSubview:levelBtn];
    levelBtn = nil;
    
    [self showPuzzleMenu];
}

- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)setGameMode: (int) gameMode
{
    game_mode = gameMode;
}

-(void) showPuzzleMenu
{
    float _x = 25.0;
    float _y = 40.0;
    int counter = 1;

    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *cryptoNumber;
    NSString *winStr;
    NSString *gameModeStr;
    
    BOOL game_status;
    int game_mode_finished = 0;
    
    for (int j = 0; j < 5; j++) {
        for (int i = 0; i < 8; i++) {
            cryptoNumber = [NSString stringWithFormat:@"%d", counter];
            
            winStr = [NSString stringWithFormat:@"%@win", cryptoNumber];
            game_status = [defaults boolForKey:winStr];
            
            gameModeStr = [NSString stringWithFormat:@"%@mode", cryptoNumber];
            game_mode_finished = [defaults integerForKey:gameModeStr];
            
            MenuOption *btn = [[MenuOption alloc] initWithFrame:CGRectMake(_x, _y, 48,48)];
            [btn setTag:counter++];
            [btn setBackgroundImage:nil forState:UIControlStateNormal];
            
            if(game_status){
                [btn setAsSolved: game_mode_finished];
                [btn addTarget:self action:@selector(showDecryptedMessage:)  forControlEvents:UIControlEventTouchUpInside];
            }else{
                //Set button image
                UIImage *btnImage = [UIImage imageNamed:@"key-icon-dull.png"];
                [btn setBackgroundImage:btnImage forState:UIControlStateNormal];
                [[btn titleLabel] setText:[NSString stringWithFormat:@"%d", counter]];
                [btn addTarget:self action:@selector(startGame:)  forControlEvents:UIControlEventTouchUpInside];
            }
            [[self view] addSubview:btn];
            [btn release];
            _x += 55;
        }
        _x = 25.0;
        _y += 55.0;
    }
    cryptoNumber = nil;
    winStr = nil;
    gameModeStr = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToTitle: (UIButton *)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)startGame: (MenuOption *)sender
{
    int gameNumber = [sender tag];
    NSLog(@"%d", gameNumber);
    GameController *gameController =  [[GameController alloc] init];
    [gameController setGameMode: game_mode];
    [gameController setMessageNumber:gameNumber];
    [[self navigationController] pushViewController:gameController animated:NO];
    [gameController release];
}

- (IBAction)showDecryptedMessage: (MenuOption *)sender
{
    int gameNumber = [sender tag];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    MessageSolvedViewController *winController =  [[MessageSolvedViewController alloc] init];
    [winController setMessageNumber:gameNumber];
    [winController setSecondsSolved:[defaults integerForKey:[NSString stringWithFormat:@"%d", gameNumber]]];
    [[self navigationController] pushViewController:winController animated:NO];
    [winController release];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}


@end
