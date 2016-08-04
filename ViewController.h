//
//  ViewController.h
//  Trom
//
//  Created by Gerardo Roa Dabike on 26/10/2015.
//  User name ACP15GR
//  Copyright © 2015 Gerardo Roa Dabike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TromView.h"
#import "Player.h"

@interface ViewController : UIViewController

@property (strong) NSMutableArray *trom;

@property (weak) IBOutlet UIButton *upButton;
@property (weak) IBOutlet UIButton *downButton;
@property (weak) IBOutlet UIButton *leftButton;
@property (weak) IBOutlet UIButton *rightButton;
@property (weak) IBOutlet UIButton *playButton;
@property (weak) IBOutlet UIButton *exitButton;

@property (weak) IBOutlet UIView *gameScreen;
@property (weak) IBOutlet UIView *arrowScreen;
@property (weak) IBOutlet UIView *endScreen;

@property (weak) IBOutlet UILabel *resultGame;

@property (strong, nonatomic) Player *userPlayer;
@property (strong, nonatomic) Player *machinePlayer;

-(void)createGrid;

-(IBAction)buttonPlay;

-(void)playersNextMov;

-(IBAction)buttonUp;
-(IBAction)buttonDown;
-(IBAction)buttonLeft;
-(IBAction)buttonRight;
-(IBAction)Buttonexit;

@end

