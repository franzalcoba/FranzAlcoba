//
//  MessageSolvedViewController.h
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/24/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageSolvedViewController : UIViewController
{
    int messageNumber;
    int secondsSolved;
}
//TEXT DISPLAYS
@property (retain, nonatomic) IBOutlet UILabel *timeSolved;
@property (retain, nonatomic) IBOutlet UITextView *messageQuote;
@property (retain, nonatomic) IBOutlet UILabel *messageAuthor;

//PUZZLE NUMBER SELECTED
- (void)setMessageNumber:(int) n;
- (void)setSecondsSolved:(int) n;
- (NSString *)formatTimeSolved;

- (IBAction)backMenu:(UIButton *)sender;

@end
