//
//  FolderStore.m
//  RestaurantOrganizer
//
//  Created by Amber Meighan on 7/8/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import "FolderStore.h"
#import "FolderObject.h"

@interface FolderStore ()

@property (nonatomic) NSMutableArray *privateFolders;

@end

@implementation FolderStore

+ (instancetype)sharedStore
{
    static FolderStore *sharedStore;
    // Do I need to create a sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}


// If a programmer calls [[BNRItemStore alloc] init], let him
// know the error of his ways
- (instancetype)init
{
    [NSException raise:@"Singleton"
                format:@"Use +[FolderStore sharedStore]"];
    return nil;
}

// Here is the real (secret) initializer
- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _privateFolders = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allFolders
{
    return [self.privateFolders copy];
}

- (FolderObject *)createFolderWithName:(NSString *)name
{
    FolderObject *folder = [[FolderObject alloc] initWithName:name];
    [self.privateFolders addObject:folder];
    return folder;
}

@end
