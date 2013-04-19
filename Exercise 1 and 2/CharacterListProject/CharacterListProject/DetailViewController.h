//
//  DetailViewController.h
//  Homepwner
//
//  Created by Franz Carelle Alcoba on 4/2/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Character;

@interface DetailViewController : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate >
{
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *IDNumberField;
    __weak IBOutlet UITextField *valueField;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UISwitch *editModeSwitch;
    UIPopoverController *imagePickerPopover;
    __weak IBOutlet UISlider *charStrength;
    __weak IBOutlet UISlider *charDexterity;
    __weak IBOutlet UISlider *charConcentration;
    __weak IBOutlet UISlider *charIntelligence;
    __weak IBOutlet UITextField *charClass;
    __weak IBOutlet UIButton *selectClassButton;

    __weak IBOutlet UILabel *charStrengthValue;
    __weak IBOutlet UILabel *charDexterityValue;
    __weak IBOutlet UILabel *charConcentrationValue;
    __weak IBOutlet UILabel *charIntelligenceValue;
}

@property (nonatomic, strong) Character *selectedCharacter;
@property (nonatomic, copy) void (^dismissBlock) (void);

- (IBAction)takePicture:(id)sender;
- (IBAction)editMode:(UISwitch *)sender;          
- (IBAction)selectJobClass:(id)sender;
- (IBAction)backgroundTapped:(id)sender;

- (IBAction)sliderValueChanged_str:(UISlider *)sender;
- (IBAction)sliderValueChanged_dex:(UISlider *)sender;
- (IBAction)sliderValueChanged_con:(UISlider *)sender;
- (IBAction)sliderValueChanged_int:(UISlider *)sender;

- (IBAction)goToTestView:(id)sender;

@end
 