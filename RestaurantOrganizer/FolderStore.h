//
//  FolderStore.h
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FolderObject;

@interface FolderStore : NSObject

@property (nonatomic, readonly, copy) NSArray *allFolders;

+(instancetype)sharedStore;
- (FolderObject *)createFolderWithName:(NSString *)name;


@end
