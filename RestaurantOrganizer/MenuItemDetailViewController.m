//
//  MenuItemDetailViewController.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "MenuItemDetailViewController.h"
#import "MenuItemObject.h"
#import "RestaurantObject.h"
#import "NewMenuItemViewController.h"

@interface MenuItemDetailViewController() <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *dishNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *dishDescriptionTextView;
@property (weak, nonatomic) IBOutlet UIImageView *dishImage;

@end

@implementation MenuItemDetailViewController


- (void) viewDidLoad
{
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir Next Ultra Light" size:35.0], NSForegroundColorAttributeName: [UIColor colorWithRed:245.0 green:239.0 blue:237.0 alpha:1.0]} forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir Next Ultra Light" size:35.0]} forState:UIControlStateNormal];
}


- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}


- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    
    // If the device has a camera, take a picture, otherwise,
    // just pick from photo library
    if ([UIImagePickerController
         isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (IBAction)cancelPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];

}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Get picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    // Put that image onto the screen in our image view
    self.dishImage.image = image;
    // Take image picker off the screen -
    // you must call this dismiss method
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"FinishedCreatingDish"])
    {
        MenuItemObject *newItem = [[MenuItemObject alloc]initWithName: self.dishNameTextField.text
                                                       andDescription: self.dishDescriptionTextView.text
                                                             andImage: self.dishImage.image];
        
        [self.restaurant addNewMenuItem:newItem];
        [self.restaurant updateLastVisited:[NSDate date]];
        
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        NewMenuItemViewController *menuList = (NewMenuItemViewController *)[nc topViewController];
        
        menuList.restaurant = self.restaurant; 
    }
}
@end
