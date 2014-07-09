//
//  DishDetailViewController.m
//  RestaurantOrganizer
//
//  Created by Carole Touma on 7/9/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "DishDetailViewController.h"
#import "MenuItemObject.h"

@implementation DishDetailViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.descriptionTextView.text = self.dishSelected.itemDescription;
    self.dishImageView.image = self.dishSelected.itemImage;
    self.dishNameLabel.text = self.dishSelected.itemName;
    
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir Next Ultra Light" size:20.0]} forState:UIControlStateNormal];
    
}

@end
