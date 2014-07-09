//
//  DishDetailViewController.h
//  RestaurantOrganizer
//
//  Created by Carole Touma on 7/9/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MenuItemObject;

@interface DishDetailViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;
@property (nonatomic, strong) MenuItemObject *dishSelected;

@end
