//
//  NewRestaurantViewController.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "Savor_AddRestaurantVC.h"
#import "RestaurantObject.h"
#import "FolderObject.h"
#import "Savor_RestaurantVC.h"
#import <Parse/Parse.h>

@interface Savor_AddRestaurantVC() <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITextView *commentTextField;
@property (strong, nonatomic) NSArray *restaurantsToShow;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSTimer *searchTimer;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) NSUInteger selectedIndex;

#define API_KEY @"AIzaSyAbL1hC6OlybF6VIW1_bpI5ZUsbM5tSRkY"

@end

@implementation Savor_AddRestaurantVC

-(void) viewDidLoad {
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir Next Ultra Light" size:35.0], NSForegroundColorAttributeName: [UIColor colorWithRed:245.0 green:239.0 blue:237.0 alpha:1.0]} forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir Next Ultra Light" size:35.0]} forState:UIControlStateNormal];
    [UITextField appearanceWhenContainedIn:[UISearchBar class], nil].font = [UIFont fontWithName:@"Avenir Next Ultra Light" size:14.0];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"FinishedNewRestaurant"]) {

        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        Savor_RestaurantVC *newItem = (Savor_RestaurantVC *)[nc topViewController];
        /* parse */
        
        // make and save the restaurant object
        PFObject *restaurant = [PFObject objectWithClassName:@"Restaurant"];

        restaurant[@"description"] = self.commentTextField.text;
        restaurant[@"lastVisited"] = [NSDate date];
        restaurant[@"myFolderPointer"] = self.currentFolderPFObject;
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        NSDictionary *restDict = self.restaurantsToShow[self.selectedIndex];
        [geocoder geocodeAddressString:restDict[@"description"] completionHandler:^(NSArray *placemarks, NSError *error) {
            if ([placemarks count] != 1) { // none found or more than one found (ambiguous location)
            }
            else {
                CLPlacemark *placemark = placemarks[0]; // get the single placemark found
                    CLLocationCoordinate2D coordinate = [placemark.location coordinate];
                    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude
                                                                  longitude:coordinate.longitude];
                restaurant[@"location"] = geoPoint;
                [restaurant saveInBackground];
                
            }
        }];

        UITableViewCell *cellSelected = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
        restaurant[@"name"] = cellSelected.textLabel.text;
        
        [restaurant save];
         
         // add it to the current folder
         PFRelation *relation = [self.currentFolderPFObject relationForKey:@"ownedRestaurants"];
         [relation addObject:restaurant];

         [self.currentFolderPFObject save];
        
        newItem.restaurantPFObject = restaurant; 

        /* end parse */
    }
}

- (IBAction)backgroundTapped:(id)sender
{
        [self.view endEditing:YES];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //if search hasn't been made within a certain amount of time and search string isn't empty, make the search request
    if (![self.searchTimer isValid]) { // timer ran out, can search again
        if (![searchText isEqualToString:@""]) { // not an empty search string
            [self makeSearchRequest];
        }
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // set the cell to have a checkmark as it has been selected
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.selectedIndex = indexPath.row;
}
- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // remove the checkmark from the cell as it has been deselected
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    self.selectedIndex = -1;
}


- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (![self.searchBar.text isEqualToString:@""]) { // not an empty search string
        [self makeSearchRequest];
    }
    [searchBar resignFirstResponder];
}

- (void) makeSearchRequest
{
    //make places request
    NSString *searchString = self.searchBar.text;
    if (![searchString isEqualToString:@""]) { // don't search if string is empty
        NSString *searchTextNoSpaces = [searchString stringByReplacingOccurrencesOfString:@" " withString:@"_"]; // replace spaces with underscores
        NSString *string = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&key=%@&type=restaurant",searchTextNoSpaces,API_KEY];
        NSURL *placesURL = [NSURL URLWithString:string];
        
        NSURLRequest *placesURLRequest = [NSURLRequest requestWithURL:placesURL];
        
        // create connection and get JSON response
        NSURLResponse *response;
        NSError *error;
        NSData *JSONplaces = [NSURLConnection sendSynchronousRequest:placesURLRequest
                                                   returningResponse:&response
                                                               error:&error];
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:JSONplaces options:0 error:&error];
        NSArray *predictions = json[@"predictions"];
        
        // parse through predictions returned
        NSMutableArray *restaurants = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in predictions) {
            if (![dict[@"types"] containsObject:@"neighborhood"] && ![dict[@"types"] containsObject:@"political"] && ![dict[@"types"] containsObject:@"locality"] && ![dict[@"types"] containsObject:@"sublocality"] && ![dict[@"types"] containsObject:@"postal_code"]) {
            [restaurants addObject:dict];
            }
        }
        self.restaurantsToShow = [restaurants copy];
        [self.tableView reloadData];
        // don't allow more requests for a certain amount of time
        self.searchTimer = [NSTimer scheduledTimerWithTimeInterval:.5
                                                            target:self
                                                          selector:@selector(doNothing)
                                                          userInfo:nil
                                                           repeats:NO];
        // set the searchResults array, show results in the table view, and reset the selectedIndex
        self.selectedIndex = -1;
    }
    
}

- (void) doNothing
{
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCellWithSubtitle"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCellWithSubtitle"];
    }
    
    if ([self.restaurantsToShow count] == 0){
            cell.textLabel.text = [NSString stringWithFormat:@"create \"%@\"",self.searchBar.text];
            cell.detailTextLabel.text = @"";
    }
    else {
        PFObject *restaurant = self.restaurantsToShow[indexPath.row];
        NSArray* description = [restaurant[@"description"] componentsSeparatedByString: @","];
        NSString* restName;
        int count = [description count];
        NSMutableString *restInfo = [NSMutableString new];
        for (int i = 0; i < count; i++) {
            if (i == 0)
                restName = description[0];
            else
            {
                if (i == count - 1) {
                    [restInfo appendString: description[i]];
                }
                else{
                    [restInfo appendString: description[i]];
                    [restInfo appendString:@","];
                }
            }
        }
        cell.textLabel.text = restName;
        cell.detailTextLabel.text = restInfo;
        cell.detailTextLabel.font = [UIFont fontWithName:@"Avenir Next Ultra Light" size:13.0];
    }
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.font = [UIFont fontWithName:@"Avenir Next Ultra Light" size:17.0];
    
    // if cell is the one selected, give it a checkmark
    if (indexPath.row == self.selectedIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    // if it is the only cell in the table view, select it (give it a checkmark and set selected index)
    else if ([self.restaurantsToShow count] == 1) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectedIndex = indexPath.row;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];

    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [self.restaurantsToShow count];
    if (count == 0 && ![self.searchBar.text isEqualToString:@""])
        return 1;
    return count;
}


- (IBAction)cancelPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}



@end
