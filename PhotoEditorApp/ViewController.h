//
//  ViewController.h
//  PhotoEditorApp
//
//  Created by webmyne systems on 26/07/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTransitionImageView.h"
#import "ImageCropView.h"

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,ImageCropViewControllerDelegate>


@property (weak, nonatomic) IBOutlet LTransitionImageView *transitionImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblHeader;
@property (weak, nonatomic) IBOutlet UIButton *btnGallery;
@property (weak, nonatomic) IBOutlet UIButton *btnCamera;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhoto:  (UIButton *)sender;
- (IBAction)selectPhoto:(UIButton *)sender;
@property (nonatomic, strong) IBOutlet ImageCropView* imageCropView;

@property (strong, nonatomic)UIImage *image;
@end

