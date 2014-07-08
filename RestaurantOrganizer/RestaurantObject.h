//
//  RestaurantObject.h
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestaurantObject : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *description;
@property (nonatomic, readonly) NSDate *lastVisted;

@end
