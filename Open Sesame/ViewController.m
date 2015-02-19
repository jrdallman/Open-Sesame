//
//  ViewController.m
//  Open Sesame
//
//  Created by Jimmy Dallman on 2/18/15.
//  Copyright (c) 2015 Jimmy Dallman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property UIButton* cage;
@property NSURL* address;
@property NSURLConnection* currentConnection;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height)];
    screenFrame = self.view.frame;
    float cageWidth = 182;
    float cageHeight = 240;
   _cage = [[UIButton alloc] initWithFrame:CGRectMake((screenFrame.size.width-cageWidth)/2, (screenFrame.size.height-cageHeight)/2, cageWidth, cageHeight)];
    _address = [[NSURL alloc] initWithString:@"STRING GOES HERE"];
    
    [_cage setImage:[UIImage imageNamed:@"restingCage.jpg"] forState:UIControlStateNormal];
    
    [_cage addTarget:self action:@selector(held:) forControlEvents:UIControlEventTouchDown];
    [_cage addTarget:self action:@selector(released:) forControlEvents:UIControlEventTouchUpInside];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview: _cage];
    
}
-(IBAction)held:(id)sender
{
    [_cage setImage:[UIImage animatedImageNamed:@"enragedCage" duration:1.0f] forState:UIControlStateNormal];
    [_cage setSelected:YES];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(open:) userInfo:nil repeats:NO];
}
-(IBAction)released:(id)sender
{
     [_cage setImage:[UIImage imageNamed:@"restingCage.jpg"] forState:UIControlStateNormal];
    [_cage setSelected:NO];
}

-(IBAction)open:(id)sender
{
    if (_cage.selected) {
        NSURLRequest *restRequest = [NSURLRequest requestWithURL:_address];
 
        if( _currentConnection)
        {
            [_currentConnection cancel];
            _currentConnection = nil;
           
        }
        
        _currentConnection = [[NSURLConnection alloc]   initWithRequest:restRequest delegate:self];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
