//
//  DishDetailViewController.h
//  RestaurantOrganizer
//
//  Created by Carole Touma on 7/9/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@class MenuItemObject;

@interface Savor_MenuItemDetailVC : UIViewController


@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;
@property (weak, nonatomic) IBOutlet UILabel *dishNameLabel;
@property (nonatomic) PFObject *dishPFObject; 

@end
