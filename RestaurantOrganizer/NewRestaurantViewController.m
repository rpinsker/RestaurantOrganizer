//
//  NewRestaurantViewController.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "NewRestaurantViewController.h"
#import "RestaurantObject.h"
#import "FolderObject.h"
#import "NewMenuItemViewController.h"

@interface NewRestaurantViewController()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextView *commentTextField;


@end

@implementation NewRestaurantViewController

-(void) viewDidLoad {
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir Next Ultra Light" size:35.0], NSForegroundColorAttributeName: [UIColor colorWithRed:245.0 green:239.0 blue:237.0 alpha:1.0]} forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir Next Ultra Light" size:35.0]} forState:UIControlStateNormal];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"FinishedNewRestaurant"]) {
        RestaurantObject *newRestaurant = [[RestaurantObject alloc]initWithName:self.nameField.text andDescription:self.commentTextField.text andFolder:self.currentFolder];
        [self.currentFolder addRestaurant:newRestaurant];
        
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        NewMenuItemViewController *newItem = (NewMenuItemViewController *)[nc topViewController];
        
        newItem.restaurant = newRestaurant;
    }
}

- (IBAction)backgroundTapped:(id)sender
{
        [self.view endEditing:YES];
}



- (IBAction)cancelPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}



@end
