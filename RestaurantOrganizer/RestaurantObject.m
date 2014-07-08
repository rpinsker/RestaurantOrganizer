//
//  RestaurantObject.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "RestaurantObject.h"

@interface RestaurantObject ()

@property (nonatomic) NSMutableString *privateName;
@property (nonatomic) NSMutableString *privateDescription;
@property (nonatomic) NSDate *lastVisted;

@end

@implementation RestaurantObject

-(instancetype)initWithName: (NSString *)name andDescription: (NSString *)description
{
    self = [super init];
    if (self)
    {
        _privateName = [name mutableCopy];
        _privateDescription = [description mutableCopy];
    }
    return self;
}

- (NSString *) name
{
    return [self.privateName copy];
}

- (NSString *) description
{
    return [self.description copy];
}

@end
