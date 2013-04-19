//
//  WebViewController.m
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/12/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize toolbar;
@synthesize webview, segmentedControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        UITabBarItem *tbi = [self tabBarItem];
        [tbi setTitle:@"Web Site"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createToolbar];
    [self goToWebSearch:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    webview = nil;
    [self setWebview:nil];
    segmentedControl = nil;
    toolbar = nil;
    [self setToolbar:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[[self tabBarController] navigationItem] setTitle:@"Web Search"];
    [[[self tabBarController] navigationItem] setRightBarButtonItem:nil animated:NO];
}

- (void)createToolbar {
    
    UIBarButtonItem *webSearch = [[UIBarButtonItem alloc] initWithTitle:@"Web" style:UIBarButtonItemStyleBordered target:self action:@selector(goToWebSearch:)];
    UIBarButtonItem *imageSearch = [[UIBarButtonItem alloc] initWithTitle:@"Images" style:UIBarButtonItemStyleBordered target:self action:@selector(goToImageSearch:)];
    UIBarButtonItem *mail = [[UIBarButtonItem alloc] initWithTitle:@"Mail" style:UIBarButtonItemStyleBordered target:self action:@selector(goToMail:)];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    NSArray *buttonItems = [NSArray arrayWithObjects:spacer, webSearch, imageSearch, mail, spacer, nil];
    [toolbar setItems:buttonItems];
}

- (void) loadURL:(NSString *)urlAddress
{
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [webview loadRequest:requestObj];
}

- (IBAction)didChangeSegmentControl:(id)sender;
{
     NSLog(@"%d", self.segmentedControl.selectedSegmentIndex);
    NSString *urlAddress;
    switch ([[self segmentedControl] selectedSegmentIndex]) {
        case 0:
            urlAddress = @"http://www.google.com";
            NSLog(@"Google");
            break;
        case 1:
            urlAddress = @"http://www.yahoo.com";
            NSLog(@"Yahoo!");
            break;
        default:
            break;
    }
    [self loadURL:urlAddress];
}

- (IBAction)goToWebSearch:(id)sender
{
    NSString *urlAddress;
    switch ([[self segmentedControl] selectedSegmentIndex]) {
        case 0:
            urlAddress = @"http://www.google.com";
            break;
        case 1:
            urlAddress = @"http://www.yahoo.com";
            break;
        default:
            urlAddress = @"http://www.google.com";
            break;
    }
    [self loadURL:urlAddress];
}

- (IBAction)goToImageSearch:(id)sender
{
    NSString *urlAddress;
    switch ([[self segmentedControl] selectedSegmentIndex]) {
        case 0:
            urlAddress = @"http://www.google.com/imghp?hl=en&tab=wi";
            break;
        case 1:
            urlAddress = @"http://www.yahoo.com";
            break;
        default:
            break;
    }
    [self loadURL:urlAddress];    
}

- (IBAction)goToMail:(id)sender
{
    NSString *urlAddress;
    switch ([[self segmentedControl] selectedSegmentIndex]) {
        case 0:
            urlAddress = @"http://www.gmail.com";
            break;
        case 1:
            urlAddress = @"http://www.mail.yahoo.com";
            break;
        default:
            break;
    }
    [self loadURL:urlAddress];
}

@end
