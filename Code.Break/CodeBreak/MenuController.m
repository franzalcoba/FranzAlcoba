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
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"paper_background_1680x1050.jpg"] ];
    [[self view] setBackgroundColor:background];
    [background release];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(backToTitle:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"Back" forState:UIControlStateNormal];
    button.frame = CGRectMake(-7.0, -7.0, 65.0, 38.0);
    [[self view] addSubview:button];
    
    [self showPuzzleMenu];
}

- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(void) showPuzzleMenu
{
    float _x = 25.0;
    float _y = 25.0;
    int counter = 1;

    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *cryptoNumber;
    NSString *winStr;
    //int seconds_elapsed = [defaults integerForKey:cryptoNumber];
    BOOL game_status;
    
    for (int j = 0; j < 5; j++) {
        for (int i = 0; i < 8; i++) {
            cryptoNumber = [NSString stringWithFormat:@"%d", counter];
            winStr = [NSString stringWithFormat:@"%@win", cryptoNumber];
            game_status = [defaults boolForKey:winStr];
            
            MenuOption *btn = [[MenuOption alloc] initWithFrame:CGRectMake(_x, _y, 50,50)];
            [btn setTag:counter++];
            [btn setBackgroundImage:nil forState:UIControlStateNormal];
            if(game_status){
                [btn setAsSolved: game_status];
                [btn addTarget:self action:@selector(showDecryptedMessage:)  forControlEvents:UIControlEventTouchUpInside];
            }else{
                //Set button image
                UIImage *btnImage = [UIImage imageNamed:@"play.png"];
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
    [[self navigationController] pushViewController:winController animated:YES];
    [winController release];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}


@end
