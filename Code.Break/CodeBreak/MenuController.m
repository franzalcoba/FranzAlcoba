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
    
    [self showPuzzleMenu];
    
}

-(void) showPuzzleMenu
{
    float _x = 25.0;
    float _y = 25.0;
    
    int counter = 1;
    
    for (int j = 0; j < 5; j++) {
        for (int i = 0; i < 8; i++) {
            MenuOption *btn = [[MenuOption alloc] initWithFrame:CGRectMake(_x, _y, 50,50)];
            [btn setTag:counter++];
            [btn addTarget:self action:@selector(startGame:)  forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:btn];
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

- (void)startGame: (MenuOption *)sender
{
    int gameNumber = [sender tag];
    NSLog(@"%d", gameNumber);
    GameController *gameController =  [[GameController alloc] init];
    [gameController setMessageNumber:gameNumber];
    [[self navigationController] pushViewController:gameController animated:NO];

}

@end
