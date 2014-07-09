//
//  MenuItemObject.h
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItemObject : NSObject

-(instancetype)initWithName: (NSString *)name andDescription: (NSString *)description andImage: (UIImage *)image; 
@property (nonatomic) NSString *itemName;
@property (nonatomic) NSString *itemDescription;
@end
