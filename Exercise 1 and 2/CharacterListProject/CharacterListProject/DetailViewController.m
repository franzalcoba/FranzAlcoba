//
//  DetailViewController.m
//  Homepwner
//
//  Created by Franz Carelle Alcoba on 4/2/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "DetailViewController.h"
#import "Character.h"
#import "CharacterList.h"
#import "CLImageStore.h"
#import "CLJobPickerViewController.h"
#import "CLAccelerometerViewController.h"

@implementation DetailViewController

@synthesize selectedCharacter;
@synthesize dismissBlock;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if(self)
    {
        UITabBarItem *tbi = [self tabBarItem];
        [tbi setTitle:@"Character Info"];
    }
    return  self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIColor *clr = nil;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        clr = [UIColor colorWithRed:0.875 green:0.88 blue:0.91 alpha:1];
    }else{
        clr = [UIColor groupTableViewBackgroundColor];
    }
    [[self view] setBackgroundColor:clr];
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"iphone_bg_wood.jpg"]];
    [[self view] setBackgroundColor:background];
     
    [charStrength setMinimumValue:0.0];
    [charStrength setMaximumValue:100.0];
    
    [charDexterity setMinimumValue:0.0];
    [charDexterity setMaximumValue:100.0];
    
    [charConcentration setMinimumValue:0.0];
    [charConcentration setMaximumValue:100.0];
    
    [charIntelligence setMinimumValue:0.0];
    [charIntelligence setMaximumValue:100.0];
    
    [[[self tabBarController] navigationItem] setTitle:@"Details"];
}

- (void)viewDidUnload
{
    nameField = nil;
    IDNumberField = nil;
    valueField = nil;
    charClass = nil;
    dateLabel = nil;
    imageView = nil;
    editModeSwitch = nil;
    [self setSelectedCharacter:nil];
    selectClassButton = nil;
    charStrengthValue = nil;
    charDexterityValue = nil;
    charConcentrationValue = nil;
    charIntelligenceValue = nil;
    [super viewDidUnload];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [[[self tabBarController] navigationItem] setTitle:@"Details"];
    [[[self tabBarController] navigationItem] setRightBarButtonItem:nil animated:NO];

    [nameField setText:[selectedCharacter charName]];
    [IDNumberField  setText:[selectedCharacter IDNumber]];
    [charClass setText:[selectedCharacter job]];
    [charClass setEnabled:NO];
    
    //Display character stats
    [charStrength setValue:[selectedCharacter statStrength]];
    [charStrengthValue setText:[NSString stringWithFormat:@"%0.2f", [selectedCharacter statStrength]]];
    
    [charDexterity setValue:[selectedCharacter statDexterity]];
    [charDexterityValue setText:[NSString stringWithFormat:@"%0.2f", [selectedCharacter statDexterity]]];
    
    [charConcentration setValue:[selectedCharacter statConcentration]];
    [charConcentrationValue setText:[NSString stringWithFormat:@"%0.2f", [selectedCharacter statConcentration]]];
    
    [charIntelligence setValue:[selectedCharacter statIntelligence]];
    [charIntelligenceValue setText:[NSString stringWithFormat:@"%0.2f", [selectedCharacter statIntelligence]]];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateStyle:NSDateFormatterMediumStyle];
    [dateformatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateLabel setText:[dateformatter stringFromDate:[selectedCharacter dateAdded]]];
    
    //FOR IMAGE
    NSString *imageKey = [selectedCharacter imageKey];
    
    if(imageKey){
        //Get image from image store
        UIImage *imageToDisplay =[[CLImageStore sharedStore] imageForKey:imageKey];
        //Put on screen in imageView
        [imageView setImage:imageToDisplay];
    }else{
        //clear imageView
        [imageView setImage:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[self view] endEditing:YES];
    
    //Save changes to item
    [selectedCharacter setCharName:[nameField text]];
    [selectedCharacter setIDNumber:[IDNumberField text]];
    [selectedCharacter setStatStrength:[charStrength value]];
    [selectedCharacter setStatDexterity:[charDexterity value]];
    [selectedCharacter setStatConcentration:[charConcentration value]];
    [selectedCharacter setStatIntelligence:[charIntelligence value]];
}

-(void) setCharacter:(Character *)i
{
    selectedCharacter = i;
}

- (IBAction)takePicture:(id)sender
{
    
    if([imagePickerPopover isPopoverVisible]){
        [imagePickerPopover dismissPopoverAnimated:YES];
        imagePickerPopover = nil;
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }else{
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePicker setDelegate:self];
    
    
    //Place image picker on screen
    //[self presentViewController:imagePicker animated:YES completion:nil];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        
        [imagePickerPopover setDelegate:self];
        [imagePickerPopover presentPopoverFromBarButtonItem:sender
                                   permittedArrowDirections:UIPopoverArrowDirectionAny
                                                   animated:YES];
    }else{
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (IBAction)editMode:(UISwitch *)sender
{
    if(editModeSwitch.on){
        NSLog(@"ON");
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Edit Mode"
                                                          message:@"Character Information can now be edited."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        [nameField setEnabled:YES];
        [nameField setBorderStyle:UITextBorderStyleRoundedRect];
        [nameField setBackgroundColor:[UIColor whiteColor]];
        
        [IDNumberField setEnabled:YES];
        [IDNumberField setBorderStyle:UITextBorderStyleRoundedRect];
        [IDNumberField setBackgroundColor:[UIColor whiteColor]];
        
        [selectClassButton setEnabled:YES];
        
        [charStrength setEnabled:YES];
        [charDexterity setEnabled:YES];
        [charConcentration setEnabled:YES];
        [charIntelligence setEnabled:YES];
    }else{
        NSLog(@"OFF");
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Edit Mode OFF"
                                             message:@"Character Information is read-only."
                                            delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [message show];
        
        [nameField setEnabled:NO];
        [nameField setBorderStyle:UITextBorderStyleNone];
        [nameField setBackgroundColor:[UIColor clearColor]];
        
        [IDNumberField setEnabled:NO];
        [IDNumberField setBorderStyle:UITextBorderStyleNone];
        [IDNumberField setBackgroundColor:[UIColor clearColor]];
        
        [selectClassButton setEnabled:NO];
        //[valueField setEnabled:NO];
        //[valueField setBorderStyle:UITextBorderStyleNone];
        
        [charStrength setEnabled:NO];
        [charDexterity setEnabled:NO];
        [charConcentration setEnabled:NO];
        [charIntelligence setEnabled:NO];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *oldKey = [selectedCharacter imageKey];
    
    if(oldKey){
        //delete old image
        [[CLImageStore sharedStore] deleteImageForKey:oldKey];
    }
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //create CFUUID - for identifier strings
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);  
    
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    
    NSString *key = (__bridge NSString *)newUniqueIDString;
    [selectedCharacter setImageKey:key];
    
    [[CLImageStore sharedStore] setImage:image
                                   forKey:[selectedCharacter imageKey]];
    
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);
    
    [imageView setImage:image];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [imagePickerPopover dismissPopoverAnimated:YES];
        imagePickerPopover = nil;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *) textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTapped:(id)sender
{
    [[self view] endEditing:YES];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)io
{
    if([[UIDevice currentDevice] userInterfaceIdiom]){
        return YES;
    }else{
        return (io == UIInterfaceOrientationPortrait);
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    NSLog(@"User dismissed popover");
    imagePickerPopover = nil;
}

/*
- (IBAction)save:(id)sender
{
    [[self presentingViewController] dismissViewControllerAnimated:YES
                                                       completion:dismissBlock];
}

- (IBAction)cancel:(id)sender
{
    [[CharacterList sharedStore] removeItem:selectedCharacter];
    [[self presentingViewController] dismissViewControllerAnimated:YES
                                                        completion:dismissBlock];
}
*/

- (IBAction)selectJobClass:(id)sender
{
    CLJobPickerViewController *clJobPickerViewController = [[CLJobPickerViewController alloc] init];
    [clJobPickerViewController setTheCharacter:selectedCharacter];
    [[self navigationController] pushViewController:clJobPickerViewController animated:YES];
}

- (IBAction)sliderValueChanged_str:(UISlider *)sender
{
    [charStrengthValue setText:[NSString stringWithFormat:@"%0.2f", sender.value ]];
}

- (IBAction)sliderValueChanged_dex:(UISlider *)sender
{
    [charDexterityValue setText:[NSString stringWithFormat:@"%0.2f", [sender value]]];
}

- (IBAction)sliderValueChanged_con:(UISlider *)sender
{
    [charConcentrationValue setText:[NSString stringWithFormat:@"%0.2f", [sender value]]];
}

- (IBAction)sliderValueChanged_int:(UISlider *)sender
{
    [charIntelligenceValue setText:[NSString stringWithFormat:@"%0.2f", [sender value]]];
}

- (IBAction)goToTestView:(id)sender
{
    CLAccelerometerViewController *gameTest = [[CLAccelerometerViewController alloc] init];
    [[self navigationController] pushViewController:gameTest animated:YES];
}

@end
