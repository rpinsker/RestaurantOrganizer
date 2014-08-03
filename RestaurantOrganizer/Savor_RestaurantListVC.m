//
//  RestaurantListViewController.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "Savor_RestaurantListVC.h"
#import "FolderObject.h"
#import "RestaurantObject.h"
#import "Savor_RestaurantVC.h"
#import "Savor_AddRestaurantVC.h"
#import <Parse/Parse.h>

@interface Savor_RestaurantListVC () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *restaurantsInFolder;

@end

@implementation Savor_RestaurantListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.view.backgroundColor =
    [UIColor colorWithPatternImage:[UIImage imageNamed:@"candlelightdinnerblurless.jpg"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir Next Ultra Light" size:20.0]} forState:UIControlStateNormal];
    
    [self.folderPFObject fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        self.title = self.folderPFObject[@"name"];
    }];

    
    // get restaurants in the folder from parse
    PFRelation *relation = [self.folderPFObject relationForKey:@"ownedRestaurants"];
    PFQuery *query = [relation query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.restaurantsInFolder = objects;
        [self.tableView reloadData];
    }];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.restaurantsInFolder count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create an instance of UITableViewCell, with default appearance
    // Get a new or recycled cell
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                    forIndexPath:indexPath];
    
    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the tableview
    
//    NSArray *restaurants = [self.folder restaurantsInFolder];
//    RestaurantObject *restaurant = restaurants[indexPath.row];
//    cell.textLabel.text = [restaurant name];
    
    PFObject *restaurant = self.restaurantsInFolder[indexPath.row];
    cell.textLabel.text = restaurant[@"name"];
    cell.textLabel.font = [UIFont fontWithName:@"Avenir Next Ultra Light" size:27.0];
    cell.textLabel.textColor = [UIColor colorWithRed:245.0 green:239.0 blue:237.0 alpha:1.0];

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddNewRestaurant"]) {
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        Savor_AddRestaurantVC *newRest = (Savor_AddRestaurantVC *)[nc topViewController];
        newRest.currentFolderPFObject = self.folderPFObject;
    }
    
    else if ([segue.identifier isEqualToString:@"restListToMenu"]) {
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        Savor_RestaurantVC *newItem = (Savor_RestaurantVC *)[nc topViewController];
        NSIndexPath *ip = [self.tableView indexPathForCell:sender];
        
        newItem.restaurantPFObject = self.restaurantsInFolder[ip.row];
    }
}

@end
