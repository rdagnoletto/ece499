//
//  NextViewController.m
//  DigitalSkateboardBeta
//
//  Created by Rob Agnoletto on 2015-01-20.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    previousTime = -1;
    previousRot.x = 0;
    previousRot.y = 0;
    previousRot.z = 0;

    pollingInterval = [self.pollingInterval doubleValue];
    if (pollingInterval > 1 || pollingInterval < 0 || [self.pollingInterval  isEqual: @""]) {
        pollingInterval = 0.1;
    }
    self.Welcome.text = [NSString stringWithFormat:@"Welcome %@!", self.nameOfUser];

    currentMaxAccelX = 0;
    currentMaxAccelY = 0;
    currentMaxAccelZ = 0;

    currentMaxRotX = 0;
    currentMaxRotY = 0;
    currentMaxRotZ = 0;

    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = pollingInterval;
    self.motionManager.gyroUpdateInterval = pollingInterval;

    self.motionManager.deviceMotionUpdateInterval = pollingInterval;

    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self outputAccelertionData:accelerometerData.acceleration withStamp:accelerometerData.timestamp];
                                                 if(error){

                                                     NSLog(@"%@", error);
                                                 }
                                             }];

    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
                                    withHandler:^(CMGyroData *gyroData, NSError *error) {
                                        [self outputRotationData:gyroData.rotationRate withStamp:gyroData.timestamp];
                                    }];


    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motionData, NSError *error) {
        [self outputMotionData:motionData withStamp:motionData.timestamp];
    }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetMaxValues:(id)sender {

    currentMaxAccelX = 0;
    currentMaxAccelY = 0;
    currentMaxAccelZ = 0;

    currentMaxRotX = 0;
    currentMaxRotY = 0;
    currentMaxRotZ = 0;

    currentCumulRotX = 0;
    currentCumulRotY = 0;
    currentCumulRotZ = 0;

}

-(void)outputAccelertionData:(CMAcceleration)acceleration withStamp:(NSTimeInterval)stamp
{



    self.accX.text = [NSString stringWithFormat:@" %.2fg",acceleration.x];
    if(fabs(acceleration.x) > fabs(currentMaxAccelX))
    {
        currentMaxAccelX = acceleration.x;
    }
    self.accY.text = [NSString stringWithFormat:@" %.2fg",acceleration.y];
    if(fabs(acceleration.y) > fabs(currentMaxAccelY))
    {
        currentMaxAccelY = acceleration.y;
    }
    self.accZ.text = [NSString stringWithFormat:@" %.2fg",acceleration.z];
    if(fabs(acceleration.z) > fabs(currentMaxAccelZ))
    {
        currentMaxAccelZ = acceleration.z;
    }

    self.maxAccX.text = [NSString stringWithFormat:@" %.2f",currentMaxAccelX];
    self.maxAccY.text = [NSString stringWithFormat:@" %.2f",currentMaxAccelY];
    self.maxAccZ.text = [NSString stringWithFormat:@" %.2f",currentMaxAccelZ];


}
-(void)outputRotationData:(CMRotationRate)rotation withStamp:(NSTimeInterval)stamp
{

    self.rotX.text = [NSString stringWithFormat:@" %.2fr/s",rotation.x];
    if(fabs(rotation.x) > fabs(currentMaxRotX))
    {
        currentMaxRotX = rotation.x;
    }
    self.rotY.text = [NSString stringWithFormat:@" %.2fr/s",rotation.y];
    if(fabs(rotation.y) > fabs(currentMaxRotY))
    {
        currentMaxRotY = rotation.y;
    }
    self.rotZ.text = [NSString stringWithFormat:@" %.2fr/s",rotation.z];
    if(fabs(rotation.z) > fabs(currentMaxRotZ))
    {
        currentMaxRotZ = rotation.z;
    }
    //NSLog(@"%.3f", stamp);
    if (previousTime == -1) {
        realInterval = pollingInterval;
    } else {
        realInterval = stamp - previousTime;
    }
    previousTime = stamp;
    smoothRot.x = (rotation.x + previousRot.x)/2;
    smoothRot.y = (rotation.y + previousRot.y)/2;
    smoothRot.z = (rotation.z + previousRot.z)/2;
    previousRot.x = rotation.x;
    previousRot.y = rotation.y;
    previousRot.z = rotation.z;
    currentCumulRotX += (realInterval*smoothRot.x)/(2*M_PI);
    currentCumulRotY += (realInterval*smoothRot.y)/(2*M_PI);
    currentCumulRotZ += (realInterval*smoothRot.z)/(2*M_PI);

//    self.maxRotX.text = [NSString stringWithFormat:@" %.2f",currentMaxRotX];
//    self.maxRotY.text = [NSString stringWithFormat:@" %.2f",currentMaxRotY];
//    self.maxRotZ.text = [NSString stringWithFormat:@" %.2f",currentMaxRotZ];
//

    self.CumulRotX.text = [NSString stringWithFormat:@" %.2f",currentCumulRotX];
    self.CumulRotY.text = [NSString stringWithFormat:@" %.2f",currentCumulRotY];
    self.CumulRotZ.text = [NSString stringWithFormat:@" %.2f",currentCumulRotZ];
}

-(void)outputMotionData:(CMDeviceMotion*)motion withStamp:(NSTimeInterval)stamp
{

    self.pitch.text = [NSString stringWithFormat:@" %.2f°",57.2957795*motion.attitude.pitch];
    self.roll.text = [NSString stringWithFormat:@" %.2f°",57.2957795*motion.attitude.roll];
    self.yaw.text = [NSString stringWithFormat:@" %.2f°",57.2957795*motion.attitude.yaw];
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
