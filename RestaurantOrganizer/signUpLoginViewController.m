//
//  signUpLoginViewController.m
//  RestaurantOrganizer
//
//  Created by Rachel Pinsker on 7/14/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "signUpLoginViewController.h"
#import "Savor_FolderListVC.h"
#import <Parse/Parse.h>

@interface signUpLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *signupUsername;
@property (weak, nonatomic) IBOutlet UITextField *signupPassword;
@property (weak, nonatomic) IBOutlet UITextField *signupEmail;

@end

@implementation signUpLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"here");

//    PFUser *u = [PFUser user];
//    u.username = @"rachel";
//    u.password = @"abc";
//    [u save];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //NSLog(@"here");

    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([PFUser currentUser]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RestaurantOrganizer" bundle:nil];
        UINavigationController *navvc = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"homeNav"];
        //HomeViewController *homevc = (HomeViewController *)[storyboard instantiateViewControllerWithIdentifier:@"homeView"];
        
        [self presentViewController:navvc animated:YES completion:NULL];
    }

}

- (IBAction)signUp:(id)sender{
    PFUser *user = [PFUser user];
    user.username = self.signupUsername.text;
    user.password = self.signupPassword.text;
    user.email = self.signupEmail.text;
    
    if ([self.signupUsername.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"missing username"
                                    message:@"make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [PFUser logInWithUsernameInBackground:user.username password:user.password
                                            block:^(PFUser *user, NSError *error) {
                                                if (user) {
                                                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RestaurantOrganizer" bundle:nil];
                                                    UINavigationController *navvc = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"homeNav"];
                                                    //HomeViewController *homevc = (HomeViewController *)[storyboard instantiateViewControllerWithIdentifier:@"homeView"];
                                                    
                                                    [self presentViewController:navvc animated:YES completion:NULL];
                                                    
                                                } else {
                                                    // The login failed. Check error to see why.
                                                }
                                            }];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
