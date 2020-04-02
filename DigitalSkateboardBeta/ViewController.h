//
//  ViewController.h
//  DigitalSkateboardBeta
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *Title;

@property (strong, nonatomic) IBOutlet UITextField *enterName;
@property (strong, nonatomic) IBOutlet UILabel *warningMessage;
@property (strong, nonatomic) IBOutlet UITextField *pollingFreq;


@property(nonatomic) BOOL *pressedAlready;

- (IBAction)PressedStart:(id)sender;


@end

