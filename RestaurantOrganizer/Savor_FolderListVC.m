//
//  HomeViewController.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "Savor_FolderListVC.h"
#import "Savor_AddFolderVC.h"
#import "FolderObject.h"
#import "FolderStore.h"
#import "Savor_RestaurantListVC.h"
#import <Parse/Parse.h>

@interface Savor_FolderListVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *folders;
@property (strong, nonatomic) NSArray *subscribedFolders;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation Savor_FolderListVC

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    
    if (self.segmentedControl.selectedSegmentIndex == 0)
        return [self.folders count];
    else
        return [self.subscribedFolders count];
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

    
    //NSArray *folders = [[FolderStore sharedStore] allFolders];
    //FolderObject *folder = folders[indexPath.row];
    //cell.textLabel.text = [folder name];
    PFObject *folder;
    if (self.segmentedControl.selectedSegmentIndex == 0)
        folder = self.folders[indexPath.row];
    else
        folder = self.subscribedFolders[indexPath.row];
    [folder fetchIfNeeded];
    cell.textLabel.text = folder[@"name"];
    cell.textLabel.font = [UIFont fontWithName:@"Avenir Next Ultra Light" size:27.0];
    cell.textLabel.textColor = [UIColor colorWithRed:245.0 green:239.0 blue:237.0 alpha:1.0];
    
    return cell;
}

- (IBAction)switchPressed:(id)sender
{
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"FromHomeToRestaurantList"]) {
        
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        Savor_RestaurantListVC *listViewController =
        (Savor_RestaurantListVC *)[nc topViewController];
        
        NSIndexPath *ip = [self.tableView indexPathForCell:sender];
        PFObject *folder;
        
        if (self.segmentedControl.selectedSegmentIndex == 0)
            folder = self.folders[ip.row];
        else
            folder = self.subscribedFolders[ip.row];
        
        listViewController.folderPFObject = folder;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //[[UINavigationBar appearance]setTitleTextAttributes:NSFontAttributeName: [UIFont fontWithName:@"AvenirNextUltraLight" size:20]];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    PFRelation *ownedFolders = [[PFUser currentUser] relationForKey:@"ownedFolders"];
    PFQuery *query = [ownedFolders query];
    self.folders = [query findObjects];
    
    PFQuery *subscriptionQuery = [PFQuery queryWithClassName:@"Subscriptions"];
    [subscriptionQuery whereKey:@"subscriber" equalTo:[PFUser currentUser]];
    [subscriptionQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray *folders = [NSMutableArray new];
        for (PFObject *subscription in objects) {
            [folders addObject:subscription[@"folder"]];
        }
        self.subscribedFolders = folders;
    }];
    
    [self.tableView reloadData];
//    [self updateTableViewForDynamicTypeSize];
    
}

@end