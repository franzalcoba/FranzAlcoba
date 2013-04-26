//
//  TitlePageController.m
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/22/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "TitlePageController.h"
#import "MenuController.h"

@interface TitlePageController ()

@end

@implementation TitlePageController
@synthesize easyModeButton, normalModeButton;

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
    
    UIImageView *backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
    [backGround setImage:[UIImage imageNamed:@"menu-bg.png"]];
    [backGround setAlpha:0.9];
    [[self view] addSubview:backGround];
    [[self view] sendSubviewToBack:backGround];
    [backGround release];
    
    UIImage *btnImage = [UIImage imageNamed:@"title button.png"];
    [easyModeButton setBackgroundImage:btnImage forState:UIControlStateNormal];
    [normalModeButton setBackgroundImage:btnImage forState:UIControlStateNormal];
    btnImage = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterMenu:(UIButton *)sender {
    MenuController *menu = [[MenuController alloc] init];
    [menu setGameMode: sender.tag];
    [[self navigationController] pushViewController:menu animated:NO];
    [menu release];
}

- (IBAction)enterHowTo:(id)sender
{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)dealloc
{
    [easyModeButton release];
    [normalModeButton release];
    [super dealloc];
}

@end
