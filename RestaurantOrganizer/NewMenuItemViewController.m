//
//  NewMenuItemViewController.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "NewMenuItemViewController.h"
#import "RestaurantObject.h"

@interface NewMenuItemViewController()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;


@end

@implementation NewMenuItemViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    self.title = [self.restaurant name];
}


@end
