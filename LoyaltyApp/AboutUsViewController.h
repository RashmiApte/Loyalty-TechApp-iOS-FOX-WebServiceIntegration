


//add new version
#import <UIKit/UIKit.h>


@interface AboutUsViewController : UIViewController {
	IBOutlet UINavigationBar *navbar;
	IBOutlet UINavigationItem *navItem;
	IBOutlet UILabel *isNetwork;
    IBOutlet UILabel *versionName;
    UIImageView *imgOnline;
    UIButton *btndrawerleft;
    

}
@property (nonatomic,strong)IBOutlet UIImageView *imgOnline;

@property(nonatomic,strong) IBOutlet UILabel *versionName;

@end
