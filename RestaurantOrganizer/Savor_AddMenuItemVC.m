//
//  MenuItemDetailViewController.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "Savor_AddMenuItemVC.h"
#import "MenuItemObject.h"
#import "RestaurantObject.h"
#import "Savor_RestaurantVC.h"

@interface Savor_AddMenuItemVC() <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *dishNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *dishDescriptionTextView;
@property (weak, nonatomic) IBOutlet UIImageView *dishImage;

@end

@implementation Savor_AddMenuItemVC


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
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        Savor_RestaurantVC *menuList = (Savor_RestaurantVC *)[nc topViewController];
        
        self.restaurantPFObject[@"lastVisited"] = [NSDate date];
        
        NSData *imageData = UIImageJPEGRepresentation(self.dishImage.image, 0.35f);
        
        // get image
        PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
        [imageFile saveInBackground];
        
        
        PFObject *newItemPFObject = [PFObject objectWithClassName:@"MenuItem"];
        newItemPFObject[@"name"] = self.dishNameTextField.text;
        newItemPFObject[@"description"] = self.dishDescriptionTextView.text;
        if (imageFile)
            newItemPFObject[@"image"] = imageFile;
        

        //dispatch_async(dispatch_get_main_queue(), ^{
            [newItemPFObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                NSLog(@"item saved");
                PFRelation *menuItemsRelations = [self.restaurantPFObject relationForKey:@"menuItems"];
                [menuItemsRelations addObject:newItemPFObject];
                [self.restaurantPFObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    NSLog(@"restaurant relation saved");
                    menuList.restaurantPFObject = self.restaurantPFObject;
                    PFRelation *menuItems = [self.restaurantPFObject relationForKey:@"menuItems"];
                    PFQuery *query = [menuItems query];
                    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                        NSLog(@"menu list saved");
                        menuList.menuItemsInRestaurant = [objects mutableCopy];
                        [menuList.menuItemsInRestaurant sortUsingComparator:^NSComparisonResult(PFObject *menuItem1, PFObject *menuItem2) {
                            return [menuItem2.createdAt compare:menuItem1.createdAt];
                        }];
                        [menuList reloadCollectionView];
                    }];
                }];
            }];
        //});
        
        menuList.restaurantPFObject = self.restaurantPFObject;
    }
    
}
@end
