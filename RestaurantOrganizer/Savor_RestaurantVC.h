//
//  NewMenuItemViewController.h
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@class RestaurantObject;

@interface Savor_RestaurantVC : UIViewController

@property (nonatomic) RestaurantObject *restaurant;
@property (nonatomic) PFObject *restaurantPFObject; 

@end
