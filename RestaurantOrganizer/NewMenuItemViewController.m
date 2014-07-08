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

@interface NewMenuItemViewController()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastVisited;


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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"menuToRestList"]) {
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        RestaurantListViewController *listViewController =
        (RestaurantListViewController *)[nc topViewController];
        
        listViewController.folder = [self.restaurant myFolder];
    }
}
@end
