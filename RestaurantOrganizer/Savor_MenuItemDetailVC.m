//
//  DishDetailViewController.m
//  RestaurantOrganizer
//
//  Created by Carole Touma on 7/9/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "Savor_MenuItemDetailVC.h"
#import "MenuItemObject.h"

@implementation Savor_MenuItemDetailVC

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.dishNameLabel.text = self.dishPFObject[@"name"];
    self.descriptionTextView.text = self.dishPFObject[@"description"];
    
    PFFile *imageFile = self.dishPFObject[@"image"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            [self.dishImageView setImage:image];
        }
        else {
            NSLog(@"Encountered error while fetching image: %@", error.userInfo[@"error"]);
        }
    }];
    
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir Next Ultra Light" size:20.0]} forState:UIControlStateNormal];
}

@end
