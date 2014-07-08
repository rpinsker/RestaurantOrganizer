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
@property (weak, nonatomic) IBOutlet UITextField *commentField;


@end

@implementation NewRestaurantViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"FinishedNewRestaurant"]) {
        RestaurantObject *newRestaurant = [[RestaurantObject alloc]initWithName:self.nameField.text andDescription:self.commentField.text andFolder:self.currentFolder];
        [self.currentFolder addRestaurant:newRestaurant];
        
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        NewMenuItemViewController *newItem = (NewMenuItemViewController *)[nc topViewController];
        
        newItem.restaurant = newRestaurant;
    }
}
- (IBAction)cancelPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}



@end
