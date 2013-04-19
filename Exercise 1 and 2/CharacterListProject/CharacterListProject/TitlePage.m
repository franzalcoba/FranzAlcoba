//
//  TitlePage.m
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/19/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "TitlePage.h"
#import "TileView.h"

@implementation TitlePage

//initialize the game controller
-(instancetype)init
{
    self = [super init];
    if (self != nil) {
        //initialize
    }
    return self;
}

-(void)displayTitle
{
    NSString *strTitle = @"iOS";
    
    //calculate the tile size
    float tileSide = ceilf( kScreenWidth*0.9 / (float)[strTitle length] ) - kTileMargin;
    
    //get the left margin for first tile
    float xOffset = (kScreenWidth - [strTitle length] * (tileSide + kTileMargin))/2;
    
    //adjust for tile center (instead the tile's origin)
    xOffset += tileSide/2;
    
    //create tiles
    for (int i=0;i<[strTitle length];i++) {
        NSString* letter = [strTitle substringWithRange:NSMakeRange(i, 1)];
        
        if (![letter isEqualToString:@" "]) {
            TileView* tile = [[TileView alloc] initWithLetter:letter andSideLength:tileSide];
            tile.center = CGPointMake(xOffset + i*(tileSide + kTileMargin), 150);//kScreenHeight/4*3);
            [tile randomize];
            //            tile.dragDelegate = self;
            
            [self.titleView addSubview:tile];
        }
    }
}

@end
