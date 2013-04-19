//
//  CLAccelerometerViewController.h
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/17/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLAccelerometerViewController : UIViewController <UIAccelerometerDelegate>
{
    __weak IBOutlet UILabel *deviceInfo;
}

//@property (nonatomic, readwrite) BOOL shakingHasStopped;

@property (nonatomic, retain) IBOutlet UILabel *labelX;
@property (nonatomic, retain) IBOutlet UILabel *labelY;
@property (nonatomic, retain) IBOutlet UILabel *labelZ;

@property (nonatomic, retain) IBOutlet UIProgressView *progressX;
@property (nonatomic, retain) IBOutlet UIProgressView *progressY;
@property (nonatomic, retain) IBOutlet UIProgressView *progressZ;

@property (nonatomic, retain) UIAccelerometer *accelerometer;

@property (weak, nonatomic) IBOutlet UISlider *shakeMeter;
@property (weak, nonatomic) IBOutlet UILabel *shakeMeterValue;

@end
