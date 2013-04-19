//
//  CLJobPickerViewController.m
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/12/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "CLJobPickerViewController.h"
#import "Character.h"
#import "DetailViewController.h"

@interface CLJobPickerViewController ()

@end

@implementation CLJobPickerViewController
@synthesize theCharacter;
@synthesize pickerView;
@synthesize dismissBlock;

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
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"iphone_bg_wood.jpg"]];
    [[self view] setBackgroundColor:background];
    
    NSArray *jobClasses = [[NSArray alloc] initWithObjects:@"Knight", @"Priestess", @"Mage", @"Witch", @"Ranger", @"Barbarian", @"Assassin", nil];
    
    [self setCharJobClasses:jobClasses];
    
    jobClass = [NSString stringWithFormat:@"%@", [jobClasses objectAtIndex:0]];
    [selectedJob setText:[NSString stringWithFormat:@"%@", [jobClasses objectAtIndex:0]]];
    [selectedJob setTextAlignment:NSTextAlignmentCenter];
    
    [[self navigationItem] setTitle:@"Job Classes"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [[self charJobClasses] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    [selectedJob setTextAlignment:NSTextAlignmentCenter];
    return [[self charJobClasses] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    jobClass = [[self charJobClasses] objectAtIndex:row];
    [selectedJob setTextAlignment:NSTextAlignmentCenter];
    [selectedJob setText:jobClass];
}

- (IBAction)changeJob:(id)sender
{
    [theCharacter setJob:jobClass];
    [[self presentingViewController] dismissViewControllerAnimated:YES
                                                        completion:dismissBlock];
}

- (void)viewDidUnload {
    selectedJob = nil;
    [super viewDidUnload];
}
@end
