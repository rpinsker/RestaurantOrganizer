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

@interface NewRestaurantViewController()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *commentField;


@end

@implementation NewRestaurantViewController


- (IBAction)donePressed:(id)sender {
    RestaurantObject *newRestaurant = [[RestaurantObject alloc]initWithName:self.nameField.text andDescription:self.commentField.text];
    [self.currentFolder addRestaurant:newRestaurant];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];

}
- (IBAction)cancelPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}



@end
