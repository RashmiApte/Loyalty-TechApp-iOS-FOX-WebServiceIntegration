//
//  HUDView.h
//  HUDView
//

#import <UIKit/UIKit.h>

@interface HudView : UIView
{
	UILabel *loadingLabel;
	HudView *loadingView;
    UILabel *lblTitle;
    UIView *viewBlack;
    
}
@property(nonatomic,strong)UIView *viewBlack;
@property (nonatomic,strong) UILabel *loadingLabel;
@property (nonatomic,strong)  HudView *loadingView;
@property (nonatomic,strong) UILabel *lblTitle;
-(id)loadingViewInView:(UIView *)aSuperview text:(NSString*)hudText;
-(void)removeView;
-(void)setUserInteractionEnabledForSuperview:(UIView *)aSuperview;

@end
