//
//  TitlePage.h
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/19/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TileView.h"

//UI defines
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height - 50)

//add more definitions here
#define kTileMargin 10

@interface TitlePage : NSObject

@property (weak, nonatomic) UIView* titleView;
- (void)displayTitle;

@end
