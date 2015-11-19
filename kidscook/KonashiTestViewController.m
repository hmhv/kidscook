//
//  KonashiTestViewController.m
//  kidscook
//
//  Created by hmhv on 2015/11/19.
//  Copyright © 2015年 hmhv. All rights reserved.
//

#import "KonashiTestViewController.h"
#import "Konashi.h"

@interface KonashiTestViewController ()

@end

@implementation KonashiTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Register event handler
    [[Konashi shared] setReadyHandler:^{
        // Set pin mode to output
        [Konashi pinMode:KonashiLED2 mode:KonashiPinModeOutput];
        
        // Make LED2 glow
        [Konashi digitalWrite:KonashiLED2 value:KonashiLevelHigh];
    }];

}

- (IBAction)findKonashi:(id)sender
{
    [Konashi find];
}

@end
