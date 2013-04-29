//
//  AnswerKey.h
//  CodeBreak
//
//  Created by Franz Carelle Alcoba on 4/23/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EncryptionKey.h"

@interface AnswerKey : UIButton

@property (strong, nonatomic) NSString *answerForKey;
@property (strong, nonatomic) NSString *answer;

@end
