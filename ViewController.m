//
//  ViewController.m
//  Trom
//
//  Created by Gerardo Roa Dabike on 26/10/2015.
//  User name ACP15GR
//  Copyright © 2015 Gerardo Roa Dabike. All rights reserved.
//

#import "ViewController.h"

// Variable for random
#define ARC4_RAND_MAX 0x100000000

// Initial position for both players
#define startPositionUser 174
#define startPositionMachine 167

// Color for both players
// I created the color here because if I want to change it
// would be easy chenge these colors here
#define userColor [UIColor greenColor]
#define machineColor [UIColor redColor]

@interface ViewController ()


@end

@implementation ViewController
UIView *myView;
NSTimer *autoTimer;
int userNextMov=4;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create user and machine players
    self.userPlayer = [[Player alloc] initWithColor:[UIColor greenColor] Position:startPositionUser Name:@"User" CurrentDirection:4 PreviousDirection:0];
    self.machinePlayer = [[Player alloc] initWithColor:[UIColor redColor] Position:startPositionMachine Name:@"Machine" CurrentDirection:2 PreviousDirection:0];
    
    // Create Game Grid
    [self createGrid];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

// Method for start the game
// Play button pressed
-(IBAction)buttonPlay{
    int pos=0;
    TromView *v=[[TromView alloc] init];
    
    // Reset start position of players
    [self.userPlayer setPosition:startPositionUser];
    [self.machinePlayer setPosition:startPositionMachine];
    
    // Reset start direction of players
    // By default Human player started going Left
    // By Default Machine player started going Right
    [self.userPlayer setCurrentDirection:4];
    [self.machinePlayer setCurrentDirection:2];
    
    userNextMov = [self.userPlayer getCurrentDirection];
    self.endScreen.hidden=TRUE;
    
    // Clean the grid for a new game
    for (int i=0; i<18; i++) {
        for(int j=0; j<18; j++){
            pos =(j*17)+(j+i);
            v=self.trom[pos];
            if (pos==167){
                v.backgroundColor=[self.machinePlayer getColor];
            }else if(pos==174){
                v.backgroundColor=[self.userPlayer getColor];
            }else{
                v.backgroundColor=[UIColor blueColor];
            }
        }
        
    }
    
    // Activate timer for game
    autoTimer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(playersNextMov) userInfo:nil repeats:YES];
  
    // Activate Arrow Buttons
    [self unBlockArrows];
}


// Method that manage the next move of both players
-(void)playersNextMov{
    int machNextMov;
    machNextMov=[self machineNextMov];
    
    // conditionOfMove<player> = 0 when the player crash the bound
    // conditionOfMove<player> = 1 when the player crash the light line
    // conditionOfMove<player> = 2 when the player move to a clean space (blue)
    
    int conditionOfMoveUser =0;
    int conditionOfMoveMachine = 0;
    
    // Machine Mov
    switch (machNextMov) {
        case 1:
            conditionOfMoveMachine=[self goUpPlayer:self.machinePlayer];
            break;
        case 2:
            conditionOfMoveMachine=[self goRightPlayer:self.machinePlayer];
            break;
        case 3:
            conditionOfMoveMachine=[self goDownPlayer:self.machinePlayer];
            break;
        case 4:
            conditionOfMoveMachine=[self goLeftPlayer:self.machinePlayer];
            break;
        default:
            break;
    }
    
    // Human Move
    switch (userNextMov) {
        case 1:
            conditionOfMoveUser=[self goUpPlayer:self.userPlayer];
            break;
        case 2:
            conditionOfMoveUser=[self goRightPlayer:self.userPlayer];
            break;
        case 3:
            conditionOfMoveUser=[self goDownPlayer:self.userPlayer];
            break;
        case 4:
            conditionOfMoveUser=[self goLeftPlayer:self.userPlayer];
            break;
        default:
            break;
    }
    
    // Result of the Move
    if((conditionOfMoveUser == 0 && conditionOfMoveMachine == 0) || (conditionOfMoveUser == 1 && conditionOfMoveMachine == 0) || (conditionOfMoveUser == 0 && conditionOfMoveMachine == 1) || (conditionOfMoveUser == 1 && conditionOfMoveMachine == 1)){
        [self endGame:3];
    }else if((conditionOfMoveUser == 0 && conditionOfMoveMachine == 2)){
        [self endGame:0];
    }else if (conditionOfMoveUser == 1 && conditionOfMoveMachine == 2){
        [self endGame:1];
    }else if(conditionOfMoveUser == 2 && (conditionOfMoveMachine == 0 || conditionOfMoveMachine == 1)){
        [self endGame:2];
    }
}


// Direction = 1 -> Move Up
// Direction = 2 -> Move Right
// Direction = 3 -> Move Down
// Direction = 4 -> Move Left

// Method ButtonUp Pressed
-(IBAction)buttonUp{
    int dir = 0;
    dir = [self.userPlayer getCurrentDirection];
    if (dir != 3){
        [self.userPlayer setCurrentDirection:1];
        userNextMov = [self.userPlayer getCurrentDirection];
    }
}
// Method ButtonRight Pressed
-(IBAction)buttonRight{
    int dir = 0;
    dir = [self.userPlayer getCurrentDirection];
    if (dir != 4){
        [self.userPlayer setCurrentDirection:2];
        userNextMov = [self.userPlayer getCurrentDirection];
    }
}
// Method ButtonDown Pressed
-(IBAction)buttonDown{
    int dir = 0;
    dir = [self.userPlayer getCurrentDirection];
    if (dir != 1){
        [self.userPlayer setCurrentDirection:3];
        userNextMov = [self.userPlayer getCurrentDirection];
    }
}
// Method ButtonLeft Pressed
-(IBAction)buttonLeft{
    int dir = 0;
    dir = [self.userPlayer getCurrentDirection];
    if (dir != 2){
        [self.userPlayer setCurrentDirection:4];
        userNextMov = [self.userPlayer getCurrentDirection];
    }
}


// End Game Method
-(void)endGame:(int)condition{
    [autoTimer invalidate];
    autoTimer=nil;
    [self blockArrows];
    if (condition == 0 ){
        self.resultGame.text = @"You Lose!!\nDon't try to scape of me";
        //self.resultGame.backgroundColor = [UIColor redColor];
    }else if(condition == 1){
        self.resultGame.text = @"You Lose!!\nI told you that I'm going to beat you";
        //self.resultGame.backgroundColor = [UIColor redColor];
    }else if (condition == 3){
        self.resultGame.text = @"You just have luck";
        //self.resultGame.backgroundColor = [UIColor orangeColor];
    }else {
        self.resultGame.text = @"Congratulation.\nYou Win!!!";
        //self.resultGame.backgroundColor = [UIColor greenColor];
    }
    self.endScreen.hidden=FALSE;
}


// Method that create the game grid
-(void)createGrid{
    
    // Declare Array
    self.trom = [[NSMutableArray alloc]init];
    
    // Create grid of 18 rows and 18 columns
    int posX=7,posY=7;
    for (int i=1; i<=18; i++) {
        for(int j=1; j<=18; j++){
            CGRect viewRect =CGRectMake(posX, posY, 16, 16);
            TromView *tromview = [[TromView alloc]initWithFrame:viewRect];
            [self.trom addObject:tromview];
            [self.gameScreen addSubview:tromview];
            posX+=17;
        }
        posY+=17;
        posX=7;
    }
}

// Method for going up Human Player
-(int)goUpPlayer:(Player*)p{
    // Method create the mov and return state
    
    // Create TROMView object
    TromView *mov=[[TromView alloc] init];
    
    // Check if the player crash the boundary
    if ([p getPosition] <= 17){
        mov = self.trom[[p getPosition]];
        mov.backgroundColor=[UIColor orangeColor];
        return 0;
    // Make Move
    }else{
        int pos = [p getPosition]-18;
        [p setPosition:pos];
        mov = self.trom[pos];
        UIColor *a =mov.backgroundColor;
        if(a == [UIColor blueColor] ){
            mov.backgroundColor=[p getColor];
        }else{
            mov.backgroundColor=[UIColor orangeColor];
            return 1;
            
        }
    }
    
    return 2;
}

// Method for going Right Human Player
-(int)goRightPlayer:(Player*)p{
    // Method create the mov and return state
    
    // Create TROMView object
    TromView *mov=[[TromView alloc] init];
    
    // Check if the player crash the boundary
    if([p getPosition] == (17*(abs([p getPosition]/18) + 1)+(abs([p getPosition]/18)))){
        mov = self.trom[[p getPosition]];
        mov.backgroundColor=[UIColor orangeColor];
        return 0;
    // Make Move
    }else{
        int pos =[p getPosition]+1;
        [p setPosition:pos];
        mov = self.trom[pos];
        UIColor *a =mov.backgroundColor;
        if(a == [UIColor blueColor] ){
            mov.backgroundColor=[p getColor];
        }else{
            mov.backgroundColor=[UIColor orangeColor];
            return 1;
        }
    }
    return 2;
}

// Method for going Down Human Player
-(int)goDownPlayer:(Player*)p{
    // Method create the mov and return state
    
    // Create TROMView object
    TromView *mov=[[TromView alloc] init];
    
    // Check if the player crash the boundary
    if ([p getPosition] >= 306){
        mov = self.trom[[p getPosition]];
        mov.backgroundColor=[UIColor orangeColor];
        return 0;
    // Make Move
    }else{
        int pos =[p getPosition]+18;
        [p setPosition:pos];
        mov = self.trom[pos];
        UIColor *a =mov.backgroundColor;
        if(a == [UIColor blueColor] ){
            mov.backgroundColor=[p getColor];
        }else{
            mov.backgroundColor=[UIColor orangeColor];
            return 1;
        }
    }
    return 2;
}


// Method for going Left Human Player
-(int)goLeftPlayer:(Player*)p{
    // Method create the mov and return state
    
    // Create TROMView object
    TromView *mov=[[TromView alloc] init];
    
    // Check if the player crash the boundary
    if([p getPosition] ==18*(abs([p getPosition] /18)) ){
        mov = self.trom[[p getPosition]];
        mov.backgroundColor=[UIColor orangeColor];
        return 0;
    // Make Move
    }else{
       
        int pos =[p getPosition]-1;
        [p setPosition:pos];
        mov = self.trom[pos];
        UIColor *a =mov.backgroundColor;
        if(a == [UIColor blueColor] ){
            mov.backgroundColor=[p getColor];
        }else{
            mov.backgroundColor=[UIColor orangeColor];
            return 1;
        }
    }
    return 2;
}


// Method that block the arrows after the end game
-(void)blockArrows{
    self.upButton.enabled=FALSE;
    self.downButton.enabled=FALSE;
    self.leftButton.enabled=FALSE;
    self.rightButton.enabled=FALSE;
}

// Method that activate the arrows after the Play Button is pressed
-(void)unBlockArrows{
    self.upButton.enabled=TRUE;
    self.downButton.enabled=TRUE;
    self.leftButton.enabled=TRUE;
    self.rightButton.enabled=TRUE;
}

// Method that check if machine can keep going UP
-(int)keepForwardUp{
    int checkPosition=0;
    int keepForward=0;
    TromView *mov=[[TromView alloc] init];
    checkPosition = [self.machinePlayer getPosition]-18;
    if (checkPosition>=0){
        mov = self.trom[checkPosition];
        if (mov.backgroundColor == [UIColor blueColor]){
            keepForward= 1;
        }else{
            keepForward= 0;
        }
        
        checkPosition-=18;
        
        if (checkPosition>=0){
            mov = self.trom[checkPosition];
            if (mov.backgroundColor == [UIColor blueColor]){
                keepForward= 1;
            }else{
                keepForward= 0;
            }
            checkPosition-=18;
            if (checkPosition>=0){
                mov = self.trom[checkPosition];
                if (mov.backgroundColor == [UIColor blueColor]){
                    keepForward= 1;
                }else{
                    keepForward= 0;
                }
            }else{
                keepForward= 0;
            }
        }else{
            keepForward= 0;
        }
    }else{
        keepForward= 0;
    }
    return keepForward;

}


// Method that check if machine can keep going RIGHT
-(int)keepForwardRight{
    int checkPosition=0;
    int keepForward=0;
    TromView *mov=[[TromView alloc] init];
    checkPosition = [self.machinePlayer getPosition]+1;
    if (checkPosition!=(17*(abs(checkPosition/18) + 1)+(abs(checkPosition/18)))){
        mov = self.trom[checkPosition];
        if (mov.backgroundColor == [UIColor blueColor]){
            keepForward= 1;
        }else{
            keepForward= 0;
        }
        
        checkPosition+=1;
        
        if (checkPosition!=(17*(abs(checkPosition/18) + 1)+(abs(checkPosition/18)))){
            mov = self.trom[checkPosition];
            if (mov.backgroundColor == [UIColor blueColor]){
                keepForward= 1;
            }else{
                keepForward= 0;
            }
            checkPosition+=1;
            if (checkPosition!=(17*(abs(checkPosition/18) + 1)+(abs(checkPosition/18)))){
                mov = self.trom[checkPosition];
                if (mov.backgroundColor == [UIColor blueColor]){
                    keepForward= 1;
                }else{
                    keepForward= 0;
                }
            }else{
                keepForward= 0;
            }
        }else{
            keepForward= 0;
        }
    }else{
        keepForward= 0;
    }
    return keepForward;
}

// Method that check if machine can keep going DOWN
-(int)keepForwardDown{
    int checkPosition=0;
    int keepForward=0;
    TromView *mov=[[TromView alloc] init];
    checkPosition = [self.machinePlayer getPosition]+18;
    if (checkPosition<324){
        mov = self.trom[checkPosition];
        if (mov.backgroundColor == [UIColor blueColor]){
            keepForward= 1;
        }else{
            keepForward= 0;
        }
        
        checkPosition+=18;
        
        if (checkPosition<324){
            mov = self.trom[checkPosition];
            if (mov.backgroundColor == [UIColor blueColor]){
                keepForward= 1;
            }else{
                keepForward= 0;
            }
            checkPosition+=18;
            if (checkPosition<324){
                mov = self.trom[checkPosition];
                if (mov.backgroundColor == [UIColor blueColor]){
                    keepForward= 1;
                }else{
                    keepForward= 0;
                }
            }else{
                keepForward= 0;
            }
        }else{
            keepForward= 0;
        }
    }else{
        keepForward= 0;
    }
    return keepForward;
}

// Method that check if machine can keep going LEFT
-(int)keepForwardLeft{
    int checkPosition=0;
    int keepForward=0;
    TromView *mov=[[TromView alloc] init];
    checkPosition = [self.machinePlayer getPosition]-1;
    if (checkPosition!=18*(abs(checkPosition /18))){
        mov = self.trom[checkPosition];
        if (mov.backgroundColor == [UIColor blueColor]){
            keepForward= 1;
        }else{
            keepForward= 0;
        }
        
        checkPosition-=1;
        
        if (checkPosition!=18*(abs(checkPosition /18))){
            mov = self.trom[checkPosition];
            if (mov.backgroundColor == [UIColor blueColor]){
                keepForward= 1;
            }else{
                keepForward= 0;
            }
            checkPosition-=1;
            if (checkPosition!= 18*(abs(checkPosition /18))){
                mov = self.trom[checkPosition];
                if (mov.backgroundColor == [UIColor blueColor]){
                    keepForward= 1;
                }else{
                    keepForward= 0;
                }
            }else{
                keepForward= 0;
            }
        }else{
            keepForward= 0;
        }
    }else{
        keepForward= 0;
    }
    return keepForward;
}

// Method that select the next mov of the Machine Player
-(int)machineNextMov{
    
    int theNextMachineDirection=2;
    Boolean freeSpot=TRUE;
    int counterOps=0,currentDirection=0;
    int keepForward=1;

    
    currentDirection = [self.machinePlayer getCurrentDirection];
    if(currentDirection == 1){
        keepForward = [self keepForwardUp];
        if(keepForward==1){
            theNextMachineDirection=1;
        }
    }else if(currentDirection==2){
        keepForward = [self keepForwardRight];
        if(keepForward==1){
            theNextMachineDirection=2;
        }
    }else if(currentDirection==3){
        keepForward = [self keepForwardDown];
        if(keepForward==1){
            theNextMachineDirection=3;
        }
    }else if(currentDirection==4){
        keepForward = [self keepForwardLeft];
        if(keepForward==1){
            theNextMachineDirection=4;
        }
    }
    do {
        if(keepForward==0){
            theNextMachineDirection = [self nextMachineDirection];
            freeSpot =[self itIsAFreeSpace:theNextMachineDirection Position:[self.machinePlayer getPosition]];
            counterOps++;
        }
    } while ((freeSpot==FALSE) && (counterOps<30));
    if (counterOps >=30){
        counterOps=20;
    }
    switch (theNextMachineDirection) {
        case 1:
            [self.machinePlayer setCurrentDirection:1];
            return [self.machinePlayer getCurrentDirection];
            break;
        case 2:
            [self.machinePlayer setCurrentDirection:2];
            return [self.machinePlayer getCurrentDirection];
            break;
        case 3:
            [self.machinePlayer setCurrentDirection:3];
            return [self.machinePlayer getCurrentDirection];
            break;
        case 4:
            [self.machinePlayer setCurrentDirection:4];
            return [self.machinePlayer getCurrentDirection];
            break;
        default:
            break;
    }
    return 0;
    
}

// Method that select a random next direction
-(int)nextMachineDirection{
    
    double rUp = arc4random()/(double)ARC4_RAND_MAX;
    double rRight= arc4random()/(double)ARC4_RAND_MAX;
    double rDown = arc4random()/(double)ARC4_RAND_MAX;
    double rLeft = arc4random()/(double)ARC4_RAND_MAX;
    double maxValue=0.0;
    int nextDirection=0;
    int dir = 0;
    
    dir = [self.machinePlayer getCurrentDirection];
    if (dir != 3){
        maxValue=rUp;
        nextDirection=1;
    }
    if (dir != 4){
        if(rRight>maxValue){
            nextDirection=2;
            maxValue=rRight;
        }
    }
    if (dir != 1){
        if(rDown>maxValue){
            nextDirection=3;
            maxValue=rRight;
        }
    }
    if (dir != 2){
        if(rLeft>maxValue){
            nextDirection=4;
        }
    }
    return nextDirection;
}


// Method that check if the random direction it is free or not
-(Boolean)itIsAFreeSpace:(int)direction Position:(int)position{
    
    int nextPosition;
    TromView *mov=[[TromView alloc] init];
    
    switch (direction) {
        case 1:
            nextPosition=position-18;
            if (nextPosition <= 17){
                return FALSE;
            }
            break;
        case 2:
            nextPosition=position+1;
            if (nextPosition == (17*(abs(nextPosition/18) + 1)+(abs(nextPosition/18)))){
                return FALSE;
            }
            break;
        case 3:
            nextPosition=position+18;
            if (nextPosition >= 306){
                return FALSE;
            }
            break;
        case 4:
            nextPosition=position-1;
            if (nextPosition == 18*(abs(nextPosition /18))){
                return FALSE;
            }
            break;
        default:
            break;
    }
    
    
    mov = self.trom[nextPosition];
    UIColor *a =mov.backgroundColor;
    if(a == [UIColor blueColor] ){
        return TRUE;
    }else{
        return FALSE;
    }
    //return TRUE;
}
-(IBAction)Buttonexit{
    exit(0);
}

@end
