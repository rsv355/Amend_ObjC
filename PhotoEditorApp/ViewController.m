//
//  ViewController.m
//  PhotoEditorApp
//
//  Created by webmyne systems on 26/07/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+tintImage.h"
#import "EditImageViewController.h"

#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)

@interface ViewController ()<EditViewControllerDelegate>
{
    UIImagePickerController *picker;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _transitionImageView.animationDuration = 2;
    
   self.lblHeader.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(0.-52));
    [self.btnCamera setImage:[UIImage imageNamed:@"camera-icon.png"] forState:UIControlStateNormal];
   // [self.btnCamera setImageTintColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnGallery setImage:[UIImage imageNamed:@"pic-icon.png"] forState:UIControlStateNormal];
    //[self.btnGallery setImageTintColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self checkCameraDeviceAvailability];
    _imageCropView.image = _image;
    _imageCropView.controlColor = [UIColor cyanColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        [self startAnimations];
    });
}
- (void)startAnimations
{
    CGFloat delay = _transitionImageView.animationDuration + 1;
    
    _transitionImageView.animationDirection = AnimationDirectionLeftToRight;
    _transitionImageView.image = [UIImage imageNamed:@"bg17.jpg"];
   //[self changeLabelTextWithcolor:[UIColor colorWithRed:(82/255.0) green:(82/255.0) blue:(82/255.0) alpha:0.8]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        _transitionImageView.animationDirection = AnimationDirectionTopToBottom;
        _transitionImageView.image = [UIImage imageNamed:@"bg174.jpg"];
       // [self changeLabelTextWithcolor:[UIColor colorWithRed:(82/255.0) green:(82/255.0) blue:(82/255.0) alpha:1.0]];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
            _transitionImageView.animationDirection = AnimationDirectionRightToLeft;
            _transitionImageView.image = [UIImage imageNamed:@"bg172.jpg"];
           
           // [self changeLabelTextWithcolor:[UIColor darkGrayColor]];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
                _transitionImageView.animationDirection = AnimationDirectionBottomToTop;
                _transitionImageView.image = [UIImage imageNamed:@"bg171.jpg"];
                //[self changeLabelTextWithcolor:[UIColor colorWithRed:(138/255.0) green:(102/255.0) blue:(69/255.0) alpha:1.0]];

                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
                    [self startAnimations];
                });
            });
        });
    });
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}
-(void) changeLabelTextWithcolor:
(UIColor *)mycolor{
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.type = kCATransitionFade;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    self.lblHeader.textColor=mycolor;
    [self.lblHeader.layer addAnimation:animation forKey:@"changeTextTransition"];
}

-(void) checkCameraDeviceAvailability {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }

}

- (IBAction)takePhoto:(UIButton *)sender {
    
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker1 didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    _image = info[UIImagePickerControllerOriginalImage];
//    self.imageView.image = chosenImage;
    

   /* EditImageViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EDIT_IMAGE"];
    viewController.image = chosenImage;
    picker1.navigationBarHidden =YES;
    viewController.delegate = (id)self;
    [picker1 pushViewController:viewController animated:YES];*/
    
    if(_image != nil){
  
        ImageCropViewController *controller = [[ImageCropViewController alloc] initWithImage:_image];
        controller.delegate = self;
        controller.blurredBackground = YES;
        picker1.navigationBarHidden = NO;
        // set the cropped area
        // controller.cropArea = CGRectMake(0, 0, 100, 200);
        [picker1 pushViewController:controller animated:YES];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker1 {
    
    [picker1 dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void)getBackFromController {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma - mark UIImage Crop Delegate methods

- (void)ImageCropViewControllerSuccess:(ImageCropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage{
   
    NSLog(@"Method called");
    EditImageViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EDIT_IMAGE"];
    viewController.image = croppedImage;
    viewController.delegate = (id)self;
    controller.navigationController.navigationBarHidden = YES;
    [controller.navigationController pushViewController:viewController animated:YES];
}

- (void)ImageCropViewControllerDidCancel:(ImageCropViewController *)controller{
    
    [controller.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = YES;
}



@end
