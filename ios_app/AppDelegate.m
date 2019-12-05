#import "AppDelegate.h"

#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"AppDelegate #application");
    
//    ViewController *fc = [[ViewController alloc]init];
//    UINavigationController *navCtrlr = [[UINavigationController alloc]initWithRootViewController:fc];
//    [self.window setRootViewController:navCtrlr];
//    navCtrlr.navigationBarHidden = YES;

    // 用制定的stroyboard构建ViewController
    ViewController *c = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateInitialViewController];

    // 创建一个导航栏的Controller UINavigationController中默认会有导航栏的UI 系统自带的
    // UINavigationController 类Activity栈
    UINavigationController *uiNavigationController = [[UINavigationController alloc]init];
    // 隐藏导航栏
    // navigation.navigationBar.hidden = YES;
    
    // Controller 类似Activity
    // 将ViewController交给uiNavigationController管理
    [uiNavigationController addChildViewController:c];
    
    NSLog(@"rootViewController = %@",self.window.rootViewController);
    
    // self.window.rootViewController = [navigation initWithRootViewController:c];
    // self.window.rootViewController = [uiNavigationController initWithRootViewController:self.window.rootViewController];
    self.window.rootViewController = uiNavigationController;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    NSLog(@"AppDelegate #applicationWillResignActive");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"AppDelegate#applicationDidEnterBackground");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSLog(@"AppDelegate#applicationWillEnterForeground");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"AppDelegate#applicationDidBecomeActive");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"AppDelegate#applicationWillTerminate");
}


@end
