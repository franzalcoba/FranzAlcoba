//
//  CLImageStore.m
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/11/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "CLImageStore.h"

@implementation CLImageStore

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

+ (CLImageStore *)sharedStore
{
    static CLImageStore *sharedStore = nil;
    if(!sharedStore){
        sharedStore = [[super allocWithZone:NULL] init];
    }
    return sharedStore;
}

- (id)init
{
    self = [super init];
    if(self){
        dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setImage:(UIImage *)i
          forKey:(NSString *)s
{
    [dictionary setObject:i forKey:s];
}

- (UIImage *)imageForKey:(NSString *)s
{
    return [dictionary objectForKey:s];
}

- (void)deleteImageForKey:(NSString *)s
{
    if(!s) return;
    [dictionary removeObjectForKey:s];
}

@end
