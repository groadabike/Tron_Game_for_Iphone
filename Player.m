//
//  Player.m
//  Trom
//
//  Created by Gerardo Roa Dabike on 27/10/2015.
//  User name ACP15GR
//  Copyright © 2015 Gerardo Roa Dabike. All rights reserved.
//

#import "Player.h"

@implementation Player

-(id)initWithColor:(UIColor*)c Position:(int)p Name:(NSString*)n CurrentDirection:(int)d PreviousDirection:(int)pd{
    self = [super init];
    if(self){
        self.color = c;
        self.position=p;
        self.namePlayer=n;
        self.currentDirection=d;
        self.previousDirection=pd;
    }
    return self;
}
/*-(void)setColor:(UIColor *)c{
    self.color = c;
}
 -(void)setPosition:(int)p{
 self.position=p;
 }
-(void)setNamePlayer:(NSString *)n{
    self.namePlayer=n;
}
-(void)setCurrentDirection:(int)c{
    self.currentDirection=c;
}
 */

-(UIColor*)getColor{
    return self.color;
}
-(int)getPosition{
    return self.position;
}
-(NSString*)getNamePlayer{
    return self.namePlayer;
}
-(int)getCurrentDirection{
    return self.currentDirection;
}
-(int)getPreviousDirection{
    return self.previousDirection;
}

@end
