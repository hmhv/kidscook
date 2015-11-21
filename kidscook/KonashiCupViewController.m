//
//  KonashiCupViewController.m
//  kidscook
//
//  Created by hmhv on 2015/11/21.
//  Copyright © 2015年 hmhv. All rights reserved.
//

#import "KonashiCupViewController.h"
#import "Konashi.h"
#import "Spring.h"

@interface KonashiCupViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *hiraMizuImageView;
@property (weak, nonatomic) IBOutlet UIImageView *namiMizuImageView;
@property (weak, nonatomic) IBOutlet UIImageView *water1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *water2ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *water3ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *water4ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *niceImageView;


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int aValue;
@property (nonatomic, assign) BOOL finished;
@property (nonatomic, assign) BOOL isLedOn;

@end

@implementation KonashiCupViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.niceImageView.alpha = 0;
    
    self.hiraMizuImageView.alpha = 0;
    
    self.water1ImageView.alpha = 0;
    self.water2ImageView.alpha = 0;
    self.water3ImageView.alpha = 0;
    self.water4ImageView.alpha = 0;

    [[Konashi shared] setConnectedHandler:^{
        NSLog(@"CONNECTED");
    }];
    
    [[Konashi shared] setReadyHandler:^{
        NSLog(@"READY");
        
        [Konashi pinMode:KonashiS1 mode:KonashiPinModeOutput];
        [Konashi digitalWrite:KonashiS1 value:KonashiLevelHigh];
        self.isLedOn = YES;
        
        [UIView animateWithDuration:1 animations:^{
            self.water1ImageView.alpha = 1;
            self.water2ImageView.alpha = 1;
            self.water3ImageView.alpha = 1;
            self.water4ImageView.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];

        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(updateAnalogValue) userInfo:nil repeats:YES];
    }];
    
    [[Konashi shared] setAnalogPinDidChangeValueHandler:^(KonashiAnalogIOPin pin, int value) {

        int aValue = [Konashi analogRead:KonashiAnalogIO0];
        
        NSLog(@"READ_AIO0: %d, %d", value, aValue);
        
        self.aValue = aValue;//MAX(self.aValue, value);
        
        CGFloat viewMin = 200;
        CGFloat viewMax = 0;
        
        CGFloat sensorMin = 50;
        CGFloat sensorMax = 1000;
        
        
        CGRect rect = self.namiMizuImageView.frame;
        rect.origin.y = 200 + (self.aValue * (viewMax - viewMin) / (sensorMax - sensorMin));
        NSLog(@"rect.origin.y %f", rect.origin.y);

        self.namiMizuImageView.frame = rect;
        
        if (self.aValue > 1000) {
            [self finish];
        }
    }];

    [Konashi findWithName:@"konashi2-f01d67"];

}

- (void)updateAnalogValue {
    
    if (self.finished)
    {
        [Konashi digitalWrite:KonashiS1 value:(self.isLedOn ? KonashiLevelLow : KonashiLevelHigh)];
        self.isLedOn = !self.isLedOn;
    }
    else
    {
        [Konashi analogReadRequest:KonashiAnalogIO0];
    }
}

- (void)finish
{
    self.finished = YES;
    
    self.hiraMizuImageView.alpha = 1;

    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{

        self.niceImageView.alpha = 1;

    } completion:^(BOOL finished) {

    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"HeartSegue" sender:nil];
        [self.timer invalidate];
        self.timer = nil;
        [Konashi disconnect];
    });

}

- (IBAction)test:(id)sender
{

    [self finish];
    
    
    //[self performSegueWithIdentifier:@"HeartSegue" sender:nil];
}
@end
