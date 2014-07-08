//
//  RestaurantListViewController.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "RestaurantListViewController.h"
#import "FolderObject.h"
#import "RestaurantObject.h"
#import "NewMenuItemViewController.h"
#import "NewRestaurantViewController.h"

@interface RestaurantListViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation RestaurantListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [self.folder name];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.folder.restaurantsInFolder count];
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
    
    NSArray *restaurants = [self.folder restaurantsInFolder];
    RestaurantObject *restaurant = restaurants[indexPath.row];
    cell.textLabel.text = [restaurant name];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView
//didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NewMenuItemViewController *menuItemController =
//    [[NewMenuItemViewController alloc] init];
//    
//    NSArray *restaurants = [self.folder restaurantsInFolder];
//    RestaurantObject *restaurant = restaurants[indexPath.row];
//    menuItemController.restaurant = restaurant;
//    
//    // Push it onto the top of the navigation controller's stack
//    [self.navigationController pushViewController:menuItemController animated:NO];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if (segue.identifier isEqualToString:@"AddNewItem") {
//        NewMenuItemViewController *newItem =
//    }
    if ([segue.identifier isEqualToString:@"AddNewRestaurant"]) {
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        NewRestaurantViewController *newRest = (NewRestaurantViewController *)[nc topViewController];
        newRest.currentFolder = self.folder;
    }
    
    else if ([segue.identifier isEqualToString:@"restListToMenu"]) {
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        NewMenuItemViewController *newItem = (NewMenuItemViewController *)[nc topViewController];
        NSIndexPath *ip = [self.tableView indexPathForCell:sender];

        newItem.restaurant = self.folder.restaurantsInFolder[ip.row];
    }

}


@end
