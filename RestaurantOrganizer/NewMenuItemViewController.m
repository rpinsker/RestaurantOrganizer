//
//  NewMenuItemViewController.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "NewMenuItemViewController.h"
#import "RestaurantListViewController.h"
#import "RestaurantObject.h"
#import "MenuItemDetailViewController.h"
#import "MenuItemObject.h"
#import "DishCell.h"
#import "DishDetailViewController.h"

@interface NewMenuItemViewController() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastVisited;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation NewMenuItemViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    self.title = [self.restaurant name];
    self.commentLabel.text = [self.restaurant description];
    NSDate *date = [self.restaurant lastVisited];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    self.lastVisited.text = [@"Last Visited: " stringByAppendingString:[dateFormatter stringFromDate:date]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.collectionView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"menuToRestList"]) {
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        RestaurantListViewController *listViewController =
        (RestaurantListViewController *)[nc topViewController];
        
        listViewController.folder = [self.restaurant myFolder];
    }
    else if ([segue.identifier isEqualToString:@"menuToNewItem"]) {
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        MenuItemDetailViewController *detailView =
        (MenuItemDetailViewController *)[nc topViewController];
        
        detailView.restaurant = self.restaurant;
    }
    else if ([segue.identifier isEqualToString:@"menuToDishDetail"]) {
        DishDetailViewController *dishViewController =
        (DishDetailViewController *) segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        
        
        dishViewController.dishSelected = [[self.restaurant menuItems] objectAtIndex:indexPath.row];
    }

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DishCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];

    MenuItemObject *menuItem = [[self.restaurant menuItems] objectAtIndex:indexPath.row];
    UIImage *image = [menuItem itemImage];
    
    
    cell.imageView.image = image;
    cell.dishNameLabel.text = menuItem.itemName;


    
    return cell;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.restaurant.menuItems count];
}

@end
