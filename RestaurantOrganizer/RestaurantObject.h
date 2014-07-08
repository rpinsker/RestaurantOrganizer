//
//  RestaurantObject.h
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FolderObject;

@interface RestaurantObject : NSObject


-(instancetype)initWithName: (NSString *)name andDescription: (NSString *)description andFolder: (FolderObject *)folderName;


@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *description;
@property (nonatomic, readonly) NSDate *lastVisited;
@property (nonatomic) FolderObject *myFolder;
@property (nonatomic, readonly) NSArray *menuItems;

@end
