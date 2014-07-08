//
//  FolderObject.h
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RestaurantObject;

@interface FolderObject : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, readonly, copy) NSArray *restaurantsInFolder;

- (instancetype) initWithName:(NSString *) name;


@end
