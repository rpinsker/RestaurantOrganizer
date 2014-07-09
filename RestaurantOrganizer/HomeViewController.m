//
//  HomeViewController.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "HomeViewController.h"
#import "FolderViewController.h"
#import "FolderObject.h"
#import "FolderStore.h"
#import "RestaurantListViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeViewController

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[[FolderStore sharedStore] allFolders] count];
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
    NSArray *folders = [[FolderStore sharedStore] allFolders];
    FolderObject *folder = folders[indexPath.row];
    cell.textLabel.text = [folder name];
    cell.textLabel.font = [UIFont fontWithName:@"Avenir Next Ultra Light" size:27.0];
    cell.textLabel.textColor = [UIColor colorWithRed:245.0 green:239.0 blue:237.0 alpha:1.0];
    
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"FromHomeToRestaurantList"]) {
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        RestaurantListViewController *listViewController =
        (RestaurantListViewController *)[nc topViewController];
        
        NSArray *folders= [[FolderStore sharedStore] allFolders];
        NSIndexPath *ip = [self.tableView indexPathForCell:sender];
        FolderObject *folder = folders[ip.row];
        listViewController.folder = folder;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //[[UINavigationBar appearance]setTitleTextAttributes:NSFontAttributeName: [UIFont fontWithName:@"AvenirNextUltraLight" size:20]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
//    [self updateTableViewForDynamicTypeSize];
    
}

@end
