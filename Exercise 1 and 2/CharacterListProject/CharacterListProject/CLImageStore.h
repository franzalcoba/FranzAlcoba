//
//  CLImageStore.h
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/11/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLImageStore : NSObject
{
    NSMutableDictionary *dictionary;
}
+ (CLImageStore *)sharedStore;

- (void)setImage:(UIImage *)i forKey:(NSString *)s;
- (UIImage *)imageForKey:(NSString *)s;
- (void)deleteImageForKey:(NSString *)s;

@end
