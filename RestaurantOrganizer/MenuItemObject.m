//
//  MenuItemObject.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "MenuItemObject.h"

@interface MenuItemObject ()

@property (nonatomic) NSMutableString *privateItemName;
@property (nonatomic) NSMutableString *privateItemDescription;
//@property (nonatomic) UIImage *itemImage;

@end

@implementation MenuItemObject

-(instancetype)initWithName: (NSString *)name andDescription: (NSString *)description andImage: (UIImage *)image {
    self = [super init];
    if (self) {
        _privateItemName = [name mutableCopy];
        _privateItemDescription = [description mutableCopy];
        _itemImage = image;
    }
    return self;
}

-(NSString *)itemName {
    return [self.privateItemName copy];
}

-(NSString *)itemDescription {
    return [self.privateItemDescription copy];
}

@end
