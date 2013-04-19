//
//  TileView.m
//  CharacterListProject
//
//  Created by Franz Carelle Alcoba on 4/19/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "TileView.h"
#import <QuartzCore/QuartzCore.h>

@implementation TileView
{
    int _xOffset, _yOffset;
    CGAffineTransform _tempTransform;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// create new tile for a given letter
-(instancetype)initWithLetter:(NSString*)letter andSideLength:(float)sideLength
{
    //the tile background
    UIImage* img = [UIImage imageNamed:@"tile.png"];
    
    //create a new object
    self = [super initWithImage:img];
    
    if (self != nil) {
        
        //resize the tile
        float scale = sideLength/img.size.width;
        self.frame = CGRectMake(0,0,img.size.width*scale, img.size.height*scale);
        
        //more initialization here
        
        //add a letter on top
        UILabel* lblChar = [[UILabel alloc] initWithFrame:self.bounds];
        lblChar.textAlignment = NSTextAlignmentCenter;
        lblChar.textColor = [UIColor whiteColor];
        lblChar.backgroundColor = [UIColor clearColor];
        lblChar.text = [letter uppercaseString];
        lblChar.font = [UIFont fontWithName:@"Verdana-Bold" size:78.0*scale];
        [self addSubview: lblChar];
        
        
        // enable user interaction
        self.userInteractionEnabled = YES;
        
        //create the tile shadow
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0;
        self.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
        self.layer.shadowRadius = 15.0f;
        self.layer.masksToBounds = NO;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
        self.layer.shadowPath = path.CGPath;
    }
    
    return self;
}

-(void)randomize
{
    //set random rotation of the tile
    //anywhere between -0.2 and 0.3 radians
    float rotation = (float)((random() % 50) /(100-0.2)); //(float)((randomf(0,50)) / ((float)100 - 0.2));
    self.transform = CGAffineTransformMakeRotation( rotation );
    
    //move randomly upwards
    int yOffset = (arc4random() % 10) - 10;
    self.center = CGPointMake(self.center.x, self.center.y + yOffset);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
