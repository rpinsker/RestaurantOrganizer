//
//  NewRestaurantViewController.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "Savor_AddRestaurantVC.h"
#import "RestaurantObject.h"
#import "FolderObject.h"
#import "Savor_RestaurantVC.h"
#import <Parse/Parse.h>

@interface Savor_AddRestaurantVC()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextView *commentTextField;


@end

@implementation Savor_AddRestaurantVC

-(void) viewDidLoad {
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir Next Ultra Light" size:35.0], NSForegroundColorAttributeName: [UIColor colorWithRed:245.0 green:239.0 blue:237.0 alpha:1.0]} forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir Next Ultra Light" size:35.0]} forState:UIControlStateNormal];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"FinishedNewRestaurant"]) {

        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        Savor_RestaurantVC *newItem = (Savor_RestaurantVC *)[nc topViewController];
        /* parse */
        
        // make and save the restaurant object
        PFObject *restaurant = [PFObject objectWithClassName:@"Restaurant"];

        restaurant[@"name"] = self.nameField.text;
        restaurant[@"description"] = self.commentTextField.text;
        restaurant[@"lastVisited"] = [NSDate date];
        restaurant[@"myFolderPointer"] = self.currentFolderPFObject;
        
        [restaurant save];
         
         // add it to the current folder
         PFRelation *relation = [self.currentFolderPFObject relationForKey:@"ownedRestaurants"];
         [relation addObject:restaurant];

         [self.currentFolderPFObject save];
        
        newItem.restaurantPFObject = restaurant; 

        /* end parse */
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
