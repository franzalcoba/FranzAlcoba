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
    
   UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"paper_background_1680x1050.jpg"] ];
   [[self view] setBackgroundColor:background];
   [background release];
    // Do any additional setup after loading the view.
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

- (IBAction)enterMenu:(id)sender {
    MenuController *menu = [[MenuController alloc] init];
    [[self navigationController] pushViewController:menu animated:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)dealloc
{
    [super dealloc];
}

@end
