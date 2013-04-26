//
//  TitlePageController.h
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/22/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitlePageController : UIViewController
{
    
}
@property (retain, nonatomic) IBOutlet UIButton *easyModeButton;
@property (retain, nonatomic) IBOutlet UIButton *normalModeButton;
- (IBAction)enterMenu:(id)sender;
- (IBAction)enterHowTo:(id)sender;

@end
