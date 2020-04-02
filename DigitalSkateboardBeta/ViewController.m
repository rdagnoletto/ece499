//
//  ViewController.m
//  DigitalSkateboardBeta
//
//

#import "ViewController.h"
#import "NextViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.enterName.delegate = self;
    self.pressedAlready = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)PressedStart:(id)sender {
    //NSLog(@"Button Pressed");
    if ([self.enterName.text  isEqual: @""]) {
        self.warningMessage.hidden = NO;
        if (!self.pressedAlready) {

            [self performSelector:@selector(fadeOutLabels) withObject:nil];

        }
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        NextViewController *nextView = (NextViewController *)[storyboard instantiateViewControllerWithIdentifier:@"NextViewController"];
        nextView.nameOfUser = self.enterName.text;
        nextView.pollingInterval = self.pollingFreq.text;
        [self presentViewController:nextView animated:YES completion:nil];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

-(void)fadeOutLabels
{
    self.pressedAlready = true;
    [UIView animateWithDuration:1.0
                          delay:3.0  /* starts the animation after 3 seconds */
                        options:UIViewAnimationCurveEaseInOut
                     animations:^ {
                         self.warningMessage.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         //[self.warningMessage removeFromSuperview];
                         self.warningMessage.hidden = YES;
                         self.warningMessage.alpha = 1.0;
                         self.pressedAlready = false;
                     }];

}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


@end