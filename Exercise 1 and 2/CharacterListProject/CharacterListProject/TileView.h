//
//  TileView.h
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/19/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TileView;

@interface TileView : UIImageView

@property (strong, nonatomic, readonly) NSString* letter;

-(instancetype)initWithLetter:(NSString*)letter andSideLength:(float)sideLength;
-(void)randomize;

@end
