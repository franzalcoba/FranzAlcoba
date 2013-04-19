//
//  CLActionViewController.m
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/15/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "CLActionViewController.h"

@interface CLActionViewController ()

@end

@implementation CLActionViewController
@synthesize currentLatitude, currentLongitude;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem *tbi = [self tabBarItem];
        [tbi setTitle:@"Others"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [worldView setHidden:YES];
    [currentLongitude setHidden:YES];
    [currentLatitude setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                         target:self
                                                                         action:@selector(showActionSheet:)];
    [[[self tabBarController] navigationItem] setRightBarButtonItem:bbi];
    [[[self tabBarController] navigationItem] setTitle:@"Others"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showActionSheet:(id)sender
{
    NSString *actionSheetTitle = @"Options"; //Action Sheet Title
    NSString *destructiveTitle = @"Clear Screen"; //Action Sheet Button Titles
    NSString *other1 = @"Request Internet Data";
    NSString *other2 = @"Show Map Location";
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:destructiveTitle
                                  otherButtonTitles:other1, other2, nil];
    [actionSheet showInView:self.view];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:@"Clear Screen"])
    {
        NSLog(@"Destructive pressed --> Delete Something");
        [webview clearsContextBeforeDrawing];
        [webview loadHTMLString:@"" baseURL:nil];
        
        [worldView setHidden:YES];
        [currentLongitude setHidden:YES];
        [currentLatitude setHidden:YES];
    }
    
    if ([buttonTitle isEqualToString:@"Cancel"]) {
        NSLog(@"Cancel pressed --> Cancel ActionSheet");
    }

    if ([buttonTitle isEqualToString:@"Request Internet Data"]) {
        NSLog(@"NSURLRequest");
        
        [currentLongitude setHidden:YES];
        [currentLatitude setHidden:YES];
        [worldView setHidden:YES];
        
        [webview clearsContextBeforeDrawing];
        
        // Create the request.
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]];
        
        // Create url connection and fire request
        NSURLConnection *conn = [[NSURLConnection alloc] init];
        (void)[conn initWithRequest:request delegate:self];
        
        [worldView setHidden:YES];
    }
    
    if ([buttonTitle isEqualToString:@"Show Map Location"]) {
        [webview loadHTMLString:@"" baseURL:nil];
        
        [worldView setHidden:NO];
        [worldView setShowsUserLocation:YES];
        
        [currentLongitude setHidden:NO];
        [currentLatitude setHidden:NO];
        
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
        locationManager.distanceFilter = kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];
        CLLocation *location = [locationManager location];
        // Configure the new event with information from the location
        CLLocationCoordinate2D coordinate = [location coordinate];
        
        float longitude=coordinate.longitude;
        float latitude=coordinate.latitude;
        
        
        [currentLatitude setText:[NSString stringWithFormat:@"Latitude: %0.2f", latitude]];
        [currentLongitude setText:[NSString stringWithFormat:@"Longitude: %0.2f", longitude]];

    }
    
  }

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    //NSLog(@"%@", _responseData);
    [webview loadData:_responseData MIMEType: @"text/html" textEncodingName: @"UTF-8" baseURL:nil];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Connection Error"
                                                      message:@"There was a problem connecting to the internet."
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];

}

- (void)viewDidUnload {
    webview = nil;
    worldView = nil;
    currentLatitude = nil;
    currentLongitude = nil;
    [self setCurrentLatitude:nil];
    [self setCurrentLongitude:nil];
    [super viewDidUnload];
}
@end
