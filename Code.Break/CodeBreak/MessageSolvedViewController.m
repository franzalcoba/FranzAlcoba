//
//  MessageSolvedViewController.m
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/24/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "MessageSolvedViewController.h"
#import "Cryptogram.h"

@interface MessageSolvedViewController ()

@end

@implementation MessageSolvedViewController
@synthesize messageAuthor, messageQuote, timeSolved;

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
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"message_bg.jpg"] ];
    [[self view] setBackgroundColor:background];
    [background release];
    
    [messageQuote setEditable:NO];
    [messageQuote setBackgroundColor:[UIColor clearColor]];
    
    [messageQuote setAlpha:0.0];
    [messageAuthor setAlpha: 0.0];
    
    [self showMessage];
}

- (void)setMessageNumber:(int) n
{
    messageNumber = n;
}

- (void)setSecondsSolved:(int) s
{
    secondsSolved = s;
}

- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (NSString *)formatTimeSolved
{
    int hours = 0;
    int minutes = secondsSolved / 60;
    int seconds = secondsSolved % 60;
    
    if(minutes > 60)
    {
        hours = minutes / 60;
        minutes = minutes % 60;
    }
    
    return [NSString stringWithFormat:@"Cryptogram solved in %02d:%02d:%02d", hours, minutes, seconds];
}

- (void)showMessage
{
    Cryptogram *cryptogramPuzzle = [[[Cryptogram alloc] initWithCryptoNumber:messageNumber] autorelease];
    [messageQuote setText:[cryptogramPuzzle cryptogram]];
    [messageAuthor setText:[cryptogramPuzzle author]];
    
    cryptogramPuzzle = nil;
    [cryptogramPuzzle dealloc];
    
    [timeSolved setText:[self formatTimeSolved]];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:3.0];
    [messageQuote setAlpha:1.0];
    [messageAuthor setAlpha:1.0];
    [UIView commitAnimations];
}

- (IBAction)backMenu:(UIButton *)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [messageQuote release];
    [messageAuthor release];
    [timeSolved release];
}

- (void)dealloc
{
    [super dealloc];
}
@end
