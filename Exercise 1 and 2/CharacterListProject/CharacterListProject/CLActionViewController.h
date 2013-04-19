//
//  CLActionViewController.h
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/15/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface CLActionViewController : UIViewController <UIActionSheetDelegate ,  NSURLConnectionDelegate, CLLocationManagerDelegate, MKMapViewDelegate>
{
    NSMutableData *_responseData;
    __weak IBOutlet UIWebView *webview;
    CLLocationManager *locationManager;
    __weak IBOutlet MKMapView *worldView;
}
@property (weak, nonatomic) IBOutlet UILabel *currentLatitude;
@property (weak, nonatomic) IBOutlet UILabel *currentLongitude;

- (void)showActionSheet:(id)sender; //Declare method to show action sheet


@end
