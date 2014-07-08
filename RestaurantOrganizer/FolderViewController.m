//
//  FolderViewController.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "FolderViewController.h"
#import "FolderStore.h"


@interface FolderViewController ()

@property (weak, nonatomic) IBOutlet UITextField *folderName;



@end

@implementation FolderViewController
- (IBAction)cancelPressed:(id)sender
{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)donePressed:(id)sender
{
    NSString *name = _folderName.text;
    [[FolderStore sharedStore] createFolderWithName:name];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    
}


@end
