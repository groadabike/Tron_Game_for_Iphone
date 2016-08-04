//
//  TromView.m
//  Trom
//
//  Created by Gerardo Roa Dabike on 26/10/2015.
//  User name ACP15GR
//  Copyright © 2015 Gerardo Roa Dabike. All rights reserved.
//

#import "TromView.h"

@implementation TromView



-(void)moveMachine{
    self.backgroundColor=[UIColor redColor];
}

-(id)init{
    self = [super init];
    if(self){
        self.backgroundColor=[UIColor blueColor];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor=[UIColor blueColor];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
