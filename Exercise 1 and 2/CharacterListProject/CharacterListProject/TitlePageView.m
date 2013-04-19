//
//  TitlePageView.m
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/19/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "TitlePageView.h"
#import "CLViewController.h"
#import "TileView.h"
#import "TitlePage.h"

@interface TitlePageView ()
@property (strong, nonatomic) TitlePage* controller;
@end

@implementation TitlePageView

-(id) init
{
    self = [super init];
    if (self != nil) {
        //create page controller
        self.controller = [[TitlePage alloc] init];
    }
    return self;
    
}
/*
-(instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self != nil) {
        //create page controller
        self.controller = [[TitlePage alloc] init];
    }
    return self;
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView* titleLayer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-100)];
    [[self view] addSubview: titleLayer];
    
    self.controller.titleView = titleLayer;
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"iphone_bg_wood.jpg"]];
    [[self view] setBackgroundColor:background];
}

-(void) viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [[self controller] displayTitle];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToCharacterList:(id)sender {
    CLViewController *characterListPage = [[CLViewController alloc] init];
    [[self navigationController] pushViewController:characterListPage animated:YES];
}
@end
