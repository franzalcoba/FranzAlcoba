//
//  WebViewController.h
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/12/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
{
    IBOutlet UIWebView *webview;
    __weak IBOutlet UISegmentedControl *segmentedControl;
    __weak IBOutlet UIToolbar *toolbar;
}
@property (nonatomic,retain) IBOutlet UIWebView *webview;
@property (nonatomic, weak) IBOutlet UISegmentedControl * segmentedControl;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

- (IBAction)didChangeSegmentControl:(id)sender;
- (IBAction)goToWebSearch:(id)sender;
- (IBAction)goToImageSearch:(id)sender;
- (IBAction)goToMail:(id)sender;
- (void) loadURL:(NSString *)urlAddress;
@end
