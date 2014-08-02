//
//  RestaurantListViewController.h
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@class FolderObject;

@interface Savor_RestaurantListVC : UITableViewController

@property (nonatomic) FolderObject *folder;
@property (nonatomic) PFObject *folderPFObject;

@end
