//
//  NewMenuItemViewController.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "Savor_RestaurantVC.h"
#import "Savor_RestaurantListVC.h"
#import "RestaurantObject.h"
#import "Savor_AddMenuItemVC.h"
#import "MenuItemObject.h"
#import "DishCell.h"
#import "Savor_MenuItemDetailVC.h"

@interface Savor_RestaurantVC() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@property (weak, nonatomic) IBOutlet UILabel *lastVisited;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *menuItemsInRestaurant;


@end

@implementation Savor_RestaurantVC

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.restaurantPFObject[@"name"];
    //self.title = [self.restaurant name];
    self.commentTextView.text = self.restaurantPFObject[@"description"];
    //self.commentTextView.text = [self.restaurant description];
    NSDate *date = self.restaurantPFObject[@"lastVisited"];
   // NSDate *date = [self.restaurant lastVisited];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  //  self.lastVisited.text = [@"Last Visited: " stringByAppendingString:[dateFormatter stringFromDate:date]];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir Next Ultra Light" size:20.0]} forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    PFRelation *menuItems = [self.restaurantPFObject relationForKey:@"menuItems"];
    PFQuery *query = [menuItems query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.menuItemsInRestaurant = objects;
        [self.collectionView reloadData];
    }];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"menuToRestList"]) {
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        Savor_RestaurantListVC *listViewController =
        (Savor_RestaurantListVC *)[nc topViewController];
        
        listViewController.folder = [self.restaurant myFolder];
        // how to retrieve a restaurant's folder?
        PFRelation *myFolderRelation = [self.restaurantPFObject relationForKey:@"myFolder"];
        PFQuery *query = [myFolderRelation query];
        NSArray *myFolder = [query findObjects];
        listViewController.folderPFObject = [myFolder lastObject];
        
    }
    else if ([segue.identifier isEqualToString:@"menuToNewItem"]) {
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        Savor_AddMenuItemVC *detailView =
        (Savor_AddMenuItemVC *)[nc topViewController];
        
        detailView.restaurantPFObject = self.restaurantPFObject;
    }
    else if ([segue.identifier isEqualToString:@"menuToDishDetail"]) {
        Savor_MenuItemDetailVC *dishViewController =
        (Savor_MenuItemDetailVC *) segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        
        dishViewController.dishPFObject = [self.menuItemsInRestaurant objectAtIndex:indexPath.row];
        
    }

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DishCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];

//    MenuItemObject *menuItem = [[self.restaurant menuItems] objectAtIndex:indexPath.row];
//    UIImage *image = [menuItem itemImage];
//    
//    
//    cell.imageView.image = image;
//    cell.dishNameLabel.text = menuItem.itemName;
    
    PFObject *menuItem = self.menuItemsInRestaurant[indexPath.row];
    cell.dishNameLabel.text = menuItem[@"name"];
    cell.imageView.image = nil;
    
    return cell;
}

//- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  //  return [self.restaurant.menuItems count];
    return [self.menuItemsInRestaurant count];
}

@end
