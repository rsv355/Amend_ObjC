//
//  EditImageViewController.h
//  PhotoEditorApp
//
//  Created by webmyne systems on 27/07/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCropView.h"

@protocol EditViewControllerDelegate <NSObject>

@required
- (void)getBackFromController;

@end

@interface EditImageViewController : UIViewController<UINavigationControllerDelegate,ImageCropViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UISlider *colorSlider;

- (IBAction)btnShow:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (strong, nonatomic)UIImage *image;
@property (weak, nonatomic) IBOutlet UIButton *btnHome;

@property (nonatomic, weak) id<EditViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *btnShow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewImageEditorHeightConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colorSliderHeightConstant;
@property (weak, nonatomic) IBOutlet UIView *viewEditor;
@property (weak, nonatomic) IBOutlet UIButton *btnCrop;
@property (weak, nonatomic) IBOutlet UIButton *btnRetouch;
@property (weak, nonatomic) IBOutlet UIButton *btnFilter;
@property (weak, nonatomic) IBOutlet UIButton *btnDownload;

- (IBAction)btnCrop:(id)sender;
- (IBAction)btnRetouch:(id)sender;
- (IBAction)btnFilter:(id)sender;
- (IBAction)btnDownload:(id)sender;

@property (nonatomic, strong) IBOutlet ImageCropView* imageCropView;
@property (nonatomic, strong) UIImage *orgImage;
@property (nonatomic, strong) NSArray *items;

@end
