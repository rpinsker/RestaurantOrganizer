//
//  FolderViewController.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "FolderViewController.h"
#import "FolderStore.h"
#import <Parse/Parse.h>


@interface FolderViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *folderName;



@end

@implementation FolderViewController

-(void)viewDidLoad {
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir Next Ultra Light" size:35.0]} forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir Next Ultra Light" size:35.0]} forState:UIControlStateNormal];
}

- (IBAction)cancelPressed:(id)sender
{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    NSString *name = _folderName.text;
    [[FolderStore sharedStore] createFolderWithName:name];
    
    PFUser *u = [PFUser currentUser];
    
    PFObject *folder = [PFObject objectWithClassName:@"Folder"];
    folder[@"name"] = name;
    folder[@"owner"] = u;
    [folder save];
    
    
    PFRelation *userToFolders = [u relationForKey:@"ownedFolders"];
    [userToFolders addObject:folder];
    [u saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    }];
    return YES;
}


- (IBAction)donePressed:(id)sender
{
    NSString *name = _folderName.text;
    [[FolderStore sharedStore] createFolderWithName:name];
    
    /* parse */
    PFUser *u = [PFUser currentUser];
    
    PFObject *folder = [PFObject objectWithClassName:@"Folder"];
    folder[@"name"] = name;
    folder[@"owner"] = u;
    [folder save];
    
    
    PFRelation *userToFolders = [u relationForKey:@"ownedFolders"];
    [userToFolders addObject:folder];
    [u saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    }];
    
    /* end parse */
}


@end
