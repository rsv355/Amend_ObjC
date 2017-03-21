//
//  EditImageViewController.m
//  PhotoEditorApp
//
//  Created by webmyne systems on 27/07/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import "EditImageViewController.h"
#import "ZBFallenBricksAnimator.h"
#import "UIButton+tintImage.h"
#import "ViewController.h"
#import "FilterCollectionViewCell.h"
#import "ImageFilter.h"


typedef enum {
    TransitionTypeNormal,
    TransitionTypeVerticalLines,
    TransitionTypeHorizontalLines,
    TransitionTypeGravity,
} TransitionType;


@interface EditImageViewController ()
<UINavigationControllerDelegate>
{
    TransitionType type;
    FilterCollectionViewCell *cell;
    UIColor *pinkColour, *darkPinkColour, *darkGrayColour;
    NSArray *retouchNameArr, *retouchIconArr, *filterNameArr,*filterIconArr;
    CIImage *originalImage;
    NSInteger selectedRetouch;
    NSInteger selectedIndex;
    
}

@end

@implementation EditImageViewController
@synthesize  imageCropView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.C63078
  //  _image = [UIImage imageNamed:@"dummy_girl.jpg"];
   
    pinkColour = [UIColor colorWithRed:(198/255.0) green:(51/255.0) blue:(120/255.0) alpha:1.0];
    
    darkGrayColour = [UIColor colorWithRed:(85/255.0) green:(85/255.0) blue:(85/255.0) alpha:1.0];
    darkPinkColour = [UIColor colorWithRed:(171/255.0) green:(42/255.0) blue:(105/255.0) alpha:1.0];
    
    [self setViewLayout];
    
    retouchNameArr = [[NSArray alloc]initWithObjects:@"Brightness", @"Contrast", @"Saturation", @"Hue", @"Gamma", nil];
     retouchIconArr = [[NSArray alloc]initWithObjects:@"brightness.png", @"contrast-button.png", @"compass.png", @"last-quarter.png", @"sharpness.png", nil];
    filterNameArr = [[NSArray alloc] initWithObjects:@"Original", @"Minimal", @"False", @"Monochrome", @"Instant", @"Tone Curve", @"Chrome", @"Fade", @"Mono", @"Noir", @"Process", @"Tonal", @"Transfer", @"Lienar Curve", @"Hatched", @"Half Tone", nil];
    filterIconArr = [[NSArray alloc] initWithObjects:@"dummy_girl.jpg", @"Minimal.png", @"False.png", @"Monochrome.png", @"Instant.png", @"ToneCurve.png", @"Chrome.png", @"Fade.png", @"Mono.png", @"Noir.png", @"Process.png", @"Tonal.png", @"Transfer.png", @"LinearCurve.png", @"Hatched.png", @"HalfTone.png", nil];

    imageCropView.image = _image;
    imageCropView.controlColor = [UIColor cyanColor];
    
    self.orgImage = _image;
    self.items = @[@"Original",@"CIMinimumComponent",@"CIFalseColor",@"CIColorMonochrome",@"CIPhotoEffectInstant",
                   @"CILinearToSRGBToneCurve",
                   @"CIPhotoEffectChrome",
                   @"CIPhotoEffectFade",
                   @"CIPhotoEffectMono",
                   @"CIPhotoEffectNoir",
                   @"CIPhotoEffectProcess",
                   @"CIPhotoEffectTonal",
                   @"CIPhotoEffectTransfer", @"CISRGBToneCurveToLinear",@"CIHatchedScreen",@"CICMYKHalftone",
                   ];
    selectedRetouch = 0;
    selectedIndex = 0;
    self.colorSlider.value = 0.5;
    
//    [self callCropImage];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) setViewLayout {
    
    self.imageview.image = _image;
    self.imageview.clipsToBounds = YES;

    self.imageview.contentMode = UIViewContentModeScaleAspectFit;
    self.imageview.autoresizingMask =
    ( UIViewAutoresizingFlexibleBottomMargin
     | UIViewAutoresizingFlexibleHeight
     | UIViewAutoresizingFlexibleLeftMargin
     | UIViewAutoresizingFlexibleRightMargin
     | UIViewAutoresizingFlexibleTopMargin
     | UIViewAutoresizingFlexibleWidth );
    
    type = TransitionTypeGravity;
    self.navigationController.delegate = self;
    
    [self.btnHome setImageTintColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnHome.layer.cornerRadius = 20.0f;
    self.viewImageEditorHeightConstant.constant = 0.0f;
    self.collectionViewHeightConstant.constant = 0.0f;
    self.viewEditor.alpha =10.0f;
    _btnShow.layer.cornerRadius = 8.0f;
    
    
    [self.btnCrop setImageTintColor:darkGrayColour forState:UIControlStateNormal];
    [self.btnDownload setImageTintColor:darkGrayColour forState:UIControlStateNormal];
    
    [self.btnShow setImageTintColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[self.colorSlider setThumbImage:[UIImage imageNamed:@"colors.png"] forState:UIControlStateNormal];
    
    self.viewEditor.layer.borderColor = pinkColour.CGColor;
    self.viewEditor.layer.borderWidth = 2.0f;
    
    
    [self setButtonScale:self.btnFilter WithWidth:0.7 withHeight:0.7 forTintColor:[UIColor lightGrayColor]];
    
    [self setButtonScale:self.btnRetouch WithWidth:1 withHeight:1 forTintColor:pinkColour];

}

-(void) setGradientColour {
    
}
#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    NSObject <UIViewControllerAnimatedTransitioning> *animator;
    
    switch (type) {
        case TransitionTypeVerticalLines:
            
            break;
        case TransitionTypeHorizontalLines:
            
            break;
        case TransitionTypeGravity:
            animator = [[ZBFallenBricksAnimator alloc] init];
            break;
        default:
            animator = nil;
    }
    
    return animator;
}

- (IBAction)pop:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0:
            type = TransitionTypeGravity;
            break;
            
        case 1:
            type = TransitionTypeHorizontalLines;
            break;
            
        case 2:
            type = TransitionTypeGravity;
            break;
    }
    ViewController *views = [self.storyboard instantiateViewControllerWithIdentifier:@"HOME"];
    [self.navigationController pushViewController:views animated:YES];

}
#pragma mark - UITableView Datasource and Delegate method

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.btnFilter.tag == 1) {
        return [filterNameArr count];
    }
    else {
        return [retouchNameArr count];
    }
    return 16;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     if (self.btnFilter.tag == 1) {
         
         cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"FilterCell" forIndexPath:indexPath];
         cell.lblFilterName.text = [filterNameArr objectAtIndex:indexPath.row];
         cell.imageFilter.image = [UIImage imageNamed:[filterIconArr objectAtIndex:indexPath.row]];
     }
     else {
         
         cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"RetouchCell" forIndexPath:indexPath];
     
         cell.imageRetouch.image = [cell.imageRetouch.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
         
         cell.lblRetouchName.text = [retouchNameArr objectAtIndex:indexPath.row];
         cell.imageRetouch.image = [UIImage imageNamed:[retouchIconArr objectAtIndex:indexPath.row]];
        
     
    }
    
    if(selectedIndex == indexPath.row) {
        
      
        cell.viewRetouch.hidden = YES;
         cell.viewImageRetouch.hidden = YES;
    
        // shadow
        cell.layer.shadowColor = [UIColor blackColor].CGColor;
        cell.layer.shadowOffset = CGSizeMake(3, 3);
        cell.layer.shadowOpacity = 0.8;
        cell.layer.shadowRadius = 4.0;
    }
    else {
       
       cell.layer.borderColor = [UIColor clearColor].CGColor;
        cell.layer.shadowColor = [UIColor clearColor].CGColor;
        cell.layer.shadowOffset = CGSizeMake(3, 3);
        cell.layer.shadowOpacity = 0;
        cell.layer.shadowRadius = 0;

    }
    return  cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    double side;
//    CGSize collectionviewSize=self.collectionView.frame.size;
    if (self.btnFilter.tag == 1) {
        side = 90;
    }
    else {
        side = 60;
    }
    return CGSizeMake(side, side);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    if (self.btnFilter.tag == 1) {
       
        if (indexPath.row == 0) {
            
            self.imageview.image = self.orgImage;

        }
        else {
        CIImage *ciImage = [[CIImage alloc] initWithImage:self.orgImage];
        //    CIImage *ciImage = [[CIImage alloc] initWithImage:self.FilteredImageView.image];
        CIFilter *filter = [CIFilter filterWithName:[self.items objectAtIndex:indexPath.row]
                                      keysAndValues:kCIInputImageKey, ciImage, nil];
        [filter setDefaults];
        
        CIContext *context = [CIContext contextWithOptions:nil];
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgImage = [context createCGImage:outputImage
                                           fromRect:[outputImage extent]];
        
        self.imageview.image = [UIImage imageWithCGImage:cgImage];
        
        CGImageRelease(cgImage);
           
        }
    }
   
    else {
      
        [self.colorSlider setValue:0.5f];
        selectedRetouch = indexPath.row;
    }
     selectedIndex = indexPath.row;
    [self.collectionView reloadData];
}


#pragma - mark UIButton IBAction methods

- (IBAction)btnShow:(id)sender {
    
    CGFloat heightConst;
    if (self.btnFilter.tag == 1) {
        heightConst = 90;
    }
    else {
        heightConst = 60;
    }
    
    if (_btnShow.tag==0) {
        _btnShow.tag=1;
      
        
        [UIView animateWithDuration:0.8
                         animations:^{
                             
                             _viewImageEditorHeightConstant.constant +=178;
                              self.collectionViewHeightConstant.constant += heightConst;
                             self.viewEditor.alpha +=1.0f;
                             [self.view layoutIfNeeded];
                            
                         }];
        [UIView beginAnimations:@"rotate" context:nil];
        [UIView setAnimationDuration:.5f];
        if( CGAffineTransformEqualToTransform( self.btnShow.imageView.transform, CGAffineTransformIdentity ) )
        {
            self.btnShow.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        } else {
            self.btnShow.imageView.transform = CGAffineTransformIdentity;
        }
        [UIView commitAnimations];
    
    }
    
    else if (_btnShow.tag==1) {
        _btnShow.tag=0;
      
        [UIView animateWithDuration:0.8
                         animations:^{
                             
                             _viewImageEditorHeightConstant.constant -=178;
                              self.collectionViewHeightConstant.constant -=heightConst;
                              self.viewEditor.alpha -=0.0f;
                             [self.view layoutIfNeeded];
                             
                         }];
        [UIView beginAnimations:@"rotate" context:nil];
        [UIView setAnimationDuration:.5f];
        if( CGAffineTransformEqualToTransform( self.btnShow.imageView.transform, CGAffineTransformIdentity ) )
        {
            self.btnShow.imageView.transform = CGAffineTransformMakeRotation(M_PI*2);
        }
        else {
        
            self.btnShow.imageView.transform = CGAffineTransformIdentity;
        }
        
        [UIView commitAnimations];

        }

}

- (IBAction)btnCrop:(id)sender {

    if(_image != nil){
        type = TransitionTypeNormal;
        ImageCropViewController *controller = [[ImageCropViewController alloc] initWithImage:_image];
        controller.delegate = self;
        controller.blurredBackground = YES;
        self.navigationController.navigationBarHidden = NO;
        // set the cropped area
        // controller.cropArea = CGRectMake(0, 0, 100, 200);
        [[self navigationController] pushViewController:controller animated:YES];
    }
    
}

-(void) callCropImage {
    if(_image != nil){
        type = TransitionTypeNormal;
        ImageCropViewController *controller = [[ImageCropViewController alloc] initWithImage:_image];
        controller.delegate = self;
        controller.blurredBackground = YES;
        self.navigationController.navigationBarHidden = NO;
        // set the cropped area
        // controller.cropArea = CGRectMake(0, 0, 100, 200);
        [[self navigationController] pushViewController:controller animated:YES];
    }

}

- (IBAction)btnRetouch:(id)sender {
    
    selectedIndex = 0;
   
    if (self.btnRetouch.tag == 0) {
       
        [self setButtonScale:self.btnFilter WithWidth:0.7 withHeight:0.7 forTintColor:[UIColor lightGrayColor]];
        [self setButtonScale:self.btnRetouch WithWidth:1 withHeight:1 forTintColor:pinkColour];
        
        self.btnFilter.tag = 0;
        self.btnRetouch.tag = 1;
        
        [UIView animateWithDuration:0.8
                         animations:^{
                             
                             self.colorSliderHeightConstant.constant +=31;
                             self.colorSlider.transform = CGAffineTransformMakeScale(1 , 1);
                             self.collectionViewHeightConstant.constant -= 30.0f;
                             
                             [self.view layoutIfNeeded];
                             
                         }];
        [self.collectionView reloadData];
    }

}



- (IBAction)btnFilter:(id)sender {
    selectedIndex = 0;
    if (self.btnFilter.tag == 0) {
      
        [self setButtonScale:self.btnRetouch WithWidth:0.7 withHeight:0.7 forTintColor:[UIColor lightGrayColor]];
        [self setButtonScale:self.btnFilter WithWidth:1 withHeight:1 forTintColor:pinkColour];
        
        self.btnFilter.tag = 1;
        self.btnRetouch.tag = 0;
        
        [UIView animateWithDuration:0.8
                         animations:^{
                             
                             self.colorSliderHeightConstant.constant -=31;
                             self.colorSlider.transform = CGAffineTransformMakeScale(0, 0);
                             self.collectionViewHeightConstant.constant += 30.0f;
                             
                             [self.view layoutIfNeeded];
                             
                         }];
        [self.collectionView reloadData];
    }

}

- (IBAction)btnDownload:(id)sender {
   
    UIImage *image = self.imageview.image;
    NSArray *items = @[image];
    
    // build an activity view controller
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    
    // and present it
    [self presentActivityController:controller];

   }
- (void)presentActivityController:(UIActivityViewController *)controller {
    
    // for iPad: make the presentation a Popover
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = self.navigationItem.leftBarButtonItem;
    
    // access the completion handler
    controller.completionWithItemsHandler = ^(NSString *activityType,
                                              BOOL completed,
                                              NSArray *returnedItems,
                                              NSError *error){
        // react to the completion
        if (completed) {
            
            // user shared an item
            //NSLog(@"We used activity type%@", activityType);
            
        } else {
            
            // user cancelled
            //NSLog(@"We didn't want to share anything after all.");
        }
        
        if (error) {
            //NSLog(@"An Error occured: %@, %@", error.localizedDescription, error.localizedFailureReason);
        }
    };
}


-(void) setButtonScale :(UIButton *)button WithWidth: (CGFloat)width withHeight: (CGFloat)height forTintColor:(UIColor *)tintColor {
    
    button.transform  = CGAffineTransformMakeScale(width, height);
    [button setImageTintColor:tintColor forState:UIControlStateNormal];
}


#pragma - mark UIImage Crop Delegate methods

- (void)ImageCropViewControllerSuccess:(ImageCropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage{
    //_image = croppedImage;
    _imageview.image = croppedImage;
    self.orgImage = croppedImage;
    //NSLCGRect cropArea = controller.cropArea;
    [[self navigationController] popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)ImageCropViewControllerDidCancel:(ImageCropViewController *)controller{
    _imageview.image = _image;
    [[self navigationController] popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = YES;
}


#pragma  - mark Retouch Effect Methods


- (UIImage*) imageWithImage:(UIImage*) source fixedHue:(CGFloat) hue alpha:(CGFloat) alpha;
// Note: the hue input ranges from 0.0 to 1.0, both red.  Values outside this range will be clamped to 0.0 or 1.0.
{
    // Find the image dimensions.
    CGSize imageSize = [source size];
    CGRect imageExtent = CGRectMake(0,0,imageSize.width,imageSize.height);
    
    // Create a context containing the image.
    UIGraphicsBeginImageContext(imageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [source drawAtPoint:CGPointMake(0,0)];
    
    // Draw the hue on top of the image.
    CGContextSetBlendMode(context, kCGBlendModeHue);
    [[UIColor colorWithHue:hue saturation:1.0 brightness:1 alpha:alpha] set];
    UIBezierPath *imagePath = [UIBezierPath bezierPathWithRect:imageExtent];
    [imagePath fill];
    
    // Retrieve the new image.
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}
-(void)changeBrightness :(UIImage *)image withBrightness:(CGFloat)brightness forEffect:(NSString *)effect{
    
    
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    
    //---
    CIFilter *brightnessFilter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, inputImage, nil];
    [brightnessFilter setDefaults];
    [brightnessFilter setValue:[NSNumber numberWithFloat:brightness] forKey:effect];
    //[brightnessFilter setValue:[NSNumber numberWithFloat:brightness] forKey:@"inputSaturation"];
    // [brightnessFilter setValue:[NSNumber numberWithFloat:brightness] forKey:@"inputContrast"];
    //---
    CIImage *outputImage = [brightnessFilter outputImage];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *outputUIImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    self.imageview.image = outputUIImage;
}
- (IBAction)sliderChanged:(UISlider *)sender
{
   // inputSaturation, inputSaturation,inputContrast

    //UIImage *image1 = [UIImage imageNamed:@"Image.png"];
    
    switch (selectedRetouch) {
        case 0:
            self.imageview.image = [self.orgImage brightness:(1+sender.value-0.5)];
            break;
       
        case 1:
            self.imageview.image = [self.orgImage contrast:(1+sender.value-0.5)];
            break;
        
        case 2:
            self.imageview.image = [self.orgImage saturate:(1+sender.value-0.5)];
            break;
            
        case 3:
            self.imageview.image = [self imageWithImage:self.orgImage fixedHue:sender.value alpha:1.0];
            break;
            
        case 4:
            
            self.imageview.image = [self.orgImage gamma:(1+sender.value-0.5)];
            break;
            
        default:
            break;
    }
    
}



@end
