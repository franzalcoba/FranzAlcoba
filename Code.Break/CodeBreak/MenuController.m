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
    UIImageView *backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
    [backGround setImage:[UIImage imageNamed:@"menu_bg.png"]];
    [[self view] addSubview:backGround];
    [[self view] sendSubviewToBack:backGround];
    [backGround release];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    UIImage *btnImage = [UIImage imageNamed:@"menu button.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(backToTitle:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:btnImage forState:UIControlStateNormal];
    button.frame = CGRectMake(5.0, -7.0, 100.0, 38.0);
    [[self view] addSubview:button];
    button = nil;
    
    UIButton *levelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (game_mode == 0) {
        [levelBtn setTitle:@"EASY GAME" forState:UIControlStateDisabled];
    }else{
        [levelBtn setTitle:@"NORMAL GAME" forState:UIControlStateDisabled];
    }
    [levelBtn setBackgroundColor:[UIColor clearColor]];
    [levelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateDisabled];
    //[levelBtn setBackgroundImage:btnImage forState:UIControlStateDisabled];
    [levelBtn setEnabled:NO];
    levelBtn.frame = CGRectMake(279.0, -7.0, 200.0, 38.0);
    [[self view] addSubview:levelBtn];
    levelBtn = nil;
    
    btnImage = nil;
    
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
    //int seconds_elapsed = [defaults integerForKey:cryptoNumber];
    BOOL game_status;
    int game_mode_finished = 0;
    
    for (int j = 0; j < 5; j++) {
        for (int i = 0; i < 8; i++) {
            cryptoNumber = [NSString stringWithFormat:@"%d", counter];
            
            winStr = [NSString stringWithFormat:@"%@win", cryptoNumber];
            game_status = [defaults boolForKey:winStr];
            
            gameModeStr = [NSString stringWithFormat:@"%@mode", cryptoNumber];
            game_mode_finished = [defaults integerForKey:gameModeStr];
            
            MenuOption *btn = [[MenuOption alloc] initWithFrame:CGRectMake(_x, _y, 50,50)];
            [btn setTag:counter++];
            [btn setBackgroundImage:nil forState:UIControlStateNormal];
            
            if(game_status){
                [btn setAsSolved: game_mode_finished];
                [btn addTarget:self action:@selector(showDecryptedMessage:)  forControlEvents:UIControlEventTouchUpInside];
            }else{
                //Set button image
                UIImage *btnImage = [UIImage imageNamed:@"key-icon-dull.png"];
                [btn setBackgroundImage:btnImage forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(startGame:)  forControlEvents:UIControlEventTouchUpInside];
            }
            [[self view] addSubview:btn];
            [btn release];
            _x += 55;
        }
        _x = 25.0;
        _y += 55.0;
    }
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
