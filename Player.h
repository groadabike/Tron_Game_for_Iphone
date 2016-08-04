//
//  Player.h
//  Trom
//
//  Created by Gerardo Roa Dabike on 27/10/2015.
//  User name ACP15GR
//  Copyright © 2015 Gerardo Roa Dabike. All rights reserved.
//
//-------------------------------------------------------------
//
//  DESCRIPTION OF THE PROGRAM
//
//  -This program was setted for IPhone 5
//
//  -The game was called TROM in order to respect the copyright of the TRON(Disney) name.
//
//  -The program create the grid game using the the view class TromView.
//  TromView create a View with a blue frame
//
//  -The grid is saved in an array, but, even when the grid it is bidimentional, the array only have one dimention
//
//  -The inlelligence of the machine are pretty simple in fact.
//  Before one move, the machine player check if the next square is blue.
//  If is TRUE the machine keep going forward, but if it is false the machine select a random direction.
//  The machine select a random direction for maximus 30 times searching a free space.
//  If after 30 intents does not find a free spot the machine take the last selected direction.
//
//  -The program have methods for players moving:
//      -goUpPlayer
//      -goRightPlayer
//      -goDownPlayer
//      -goLeftPlayer
//  Both players (Machine and Human) Call these method from the playersNextMov method
//
//  Human Move
//  When the human press an arrow button call the corresponding method and update the next direction
//  in a global variable called "userNextMov". After the moving the system save the result condition of that moving
//  in the "conditionOfMoveUser" variable.
//
//  Machine Move
//  First, the system call the "machineNextMov" method
//  This method get the current direction of the machine and check if can keep going forward
//  but if not, the system call "nextMachineDirection" method that select a random direction.
//  With a direction selected, the system save the condition resutl in "conditionOfMoveMachine" variable
//
//  Final
//  In order to know who won the game, the system compare the values of the variables "conditionOfMoveMachine"
//  and "conditionOfMoveUser".
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Player : NSObject

@property int position;
@property (strong, nonatomic) UIColor *color;
@property NSString *namePlayer;
@property int currentDirection;
@property int previousDirection;

-(id)initWithColor:(UIColor*)c Position:(int)p Name:(NSString*)n CurrentDirection:(int)d PreviousDirection:(int)pd;

//-(void)setColor:(UIColor *)c;
//-(void)setPosition:(int)p;
//-(void)setNamePlayer:(NSString *)n;
//-(void)setCurrentDirection:(int)c;
-(UIColor*)getColor;
-(int)getPosition;
-(NSString*)getNamePlayer;
-(int)getCurrentDirection;
-(int)getPreviousDirection;

@end
