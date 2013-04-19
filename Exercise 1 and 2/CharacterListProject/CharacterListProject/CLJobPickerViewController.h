//
//  CLJobPickerViewController.h
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/12/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Character;

@interface CLJobPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    __weak IBOutlet UIPickerView *jobClassPicker;
    __weak IBOutlet UILabel *selectedJob;
    NSString *jobClass;
}

@property(nonatomic,retain) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *charJobClasses;
@property (nonatomic, strong) Character *theCharacter;
@property (nonatomic, copy) void (^dismissBlock) (void);

- (IBAction)changeJob:(id)sender;

@end
