//
//  NextViewController.h
//  DigitalSkateboardBeta
//
//  Created by Rob Agnoletto on 2015-01-20.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

double currentMaxAccelX;
double currentMaxAccelY;
double currentMaxAccelZ;
double currentMaxRotX;
double currentMaxRotY;
double currentMaxRotZ;

double currentCumulRotX;
double currentCumulRotY;
double currentCumulRotZ;

double previousTime;
struct threeDimensions {
    double x;
    double y;
    double z;
};
struct threeDimensions previousRot;
struct threeDimensions smoothRot;
double pollingInterval;
double realInterval;

@interface NextViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *Welcome;
@property (strong, nonatomic) IBOutlet UIButton *Back;

@property (strong, nonatomic) IBOutlet UILabel *accX;
@property (strong, nonatomic) IBOutlet UILabel *accY;
@property (strong, nonatomic) IBOutlet UILabel *accZ;

@property (strong, nonatomic) IBOutlet UILabel *maxAccX;
@property (strong, nonatomic) IBOutlet UILabel *maxAccY;
@property (strong, nonatomic) IBOutlet UILabel *maxAccZ;

@property (strong, nonatomic) IBOutlet UILabel *rotX;
@property (strong, nonatomic) IBOutlet UILabel *rotY;
@property (strong, nonatomic) IBOutlet UILabel *rotZ;

@property (strong, nonatomic) IBOutlet UILabel *pitch;
@property (strong, nonatomic) IBOutlet UILabel *roll;
@property (strong, nonatomic) IBOutlet UILabel *yaw;

@property (strong, nonatomic) IBOutlet UILabel *CumulRotX;
@property (strong, nonatomic) IBOutlet UILabel *CumulRotY;
@property (strong, nonatomic) IBOutlet UILabel *CumulRotZ;


@property (strong, nonatomic) CMMotionManager *motionManager;

@property(nonatomic) NSString *nameOfUser;
@property(nonatomic) NSString *pollingInterval;

@end
