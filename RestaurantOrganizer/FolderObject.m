//
//  FolderObject.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "FolderObject.h"
#import "RestaurantObject.h"

@interface FolderObject()

@property (nonatomic) NSMutableArray *privateRestaurants;

@end

@implementation FolderObject


- (instancetype) initWithName:(NSString *)name
{
    self = [super init];
    
    if (self) {
        _name = name;
        _privateRestaurants = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *) restaurantsInFolder
{
    return [self.privateRestaurants copy];
}

- (void) addRestaurant: (RestaurantObject *)newR
{
    [self.privateRestaurants addObject:newR];
}

@end
