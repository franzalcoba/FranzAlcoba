//
//  CLAccelerometerViewController.m
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/17/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "CLAccelerometerViewController.h"

@interface CLAccelerometerViewController ()

@end

@implementation CLAccelerometerViewController
@synthesize  labelX, labelY, labelZ, progressX, progressY, progressZ;
@synthesize shakeMeter, shakeMeterValue; //shakingHasStopped;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:NO];
    
    [self becomeFirstResponder];
    self.accelerometer.delegate = self;
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:NO];
    self.accelerometer.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [shakeMeter setMinimumValue:0.0];
    [shakeMeter setMaximumValue:100.0];
    [shakeMeter setEnabled:NO];
    
    // Request to turn on accelerometer and begin receiving accelerometer events
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    self.accelerometer = [UIAccelerometer sharedAccelerometer];
    self.accelerometer.updateInterval = .1;
    self.accelerometer.delegate = self;
}

-(void) viewDidDisappear {
    // Request to stop receiving accelerometer events and turn off accelerometer
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    self.accelerometer.delegate = nil;
    [self resignFirstResponder];
    [super viewDidDisappear:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)orientationChanged:(NSNotification *)notification {
    // Respond to changes in device orientation
    
    UIDeviceOrientation dOrientation = [UIDevice currentDevice].orientation;
    switch (dOrientation) {
        case UIDeviceOrientationFaceDown:
            [deviceInfo setText:@"FACE DOWN"];
            break;
        case UIDeviceOrientationFaceUp:
            [deviceInfo setText:@"FACE UP"];
            break;
        case UIDeviceOrientationLandscapeLeft:
            [deviceInfo setText:@"Device tilted -90˚"];
            break;
        case UIDeviceOrientationLandscapeRight:
            [deviceInfo setText:@"Device tilted 90˚"];
            break;
        case UIDeviceOrientationPortrait:
            [deviceInfo setText:@"NORMAL position."];
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            [deviceInfo setText:@"Upside Down."];
            break;
        default:
            [deviceInfo setText:@"Huh?"];
            break;
    }
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    labelX.text = [NSString stringWithFormat:@"%@%d", @"X: ", (int)acceleration.x];
    labelY.text = [NSString stringWithFormat:@"%@%d", @"Y: ", (int)acceleration.y];
    labelZ.text = [NSString stringWithFormat:@"%@%d", @"Z: ", (int)acceleration.z];
    
    self.progressX.progress = ABS(acceleration.x);
    self.progressY.progress = ABS(acceleration.y);
    self.progressZ.progress = ABS(acceleration.z);
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake )
    {
        //NSLog(@"Shaking has begun.");
        //[self setShakingHasStopped:NO];
        //[self increaseMeter];
        [shakeMeter setValue:[shakeMeter value]+1];
        [shakeMeterValue setText:[NSString stringWithFormat:@"%d%%", (int)[shakeMeter value]]];
    }
}

/*
-(void)increaseMeter
{
    while(!shakingHasStopped){
        [shakeMeter setValue:[shakeMeter value]+1];
        [shakeMeterValue setText:[NSString stringWithFormat:@"%d%%", (int)[shakeMeter value]]];
    }
}
*/
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake )
    {
        //[self setShakingHasStopped:YES];
        // shaking has ended
        //NSLog(@"Shake has ended.");
    }
}

- (void)viewDidUnload {
    deviceInfo = nil;
    progressX = nil;
    progressY = nil;
    progressZ = nil;
    labelX = nil;
    labelY = nil;
    labelZ = nil;
    [[self accelerometer] setDelegate:nil];
    [self setShakeMeter:nil];
    [self setShakeMeterValue:nil];
    [super viewDidUnload];
}
@end
