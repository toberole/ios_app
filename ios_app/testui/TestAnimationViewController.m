#import "TestAnimationViewController.h"

/*
 
 Core Animation（核心动画），它是一组非常强大的跨平台的动画处理API，iOS和mac OS均可使用，使用它能做出非常炫丽的动画效果。
 Core Animation是直接作用在CALayer上，且都是在后台操作的，不会阻塞主线程。
 
 CALayer简介
 CALayer包含在QuartzCore框架中，这是一个跨平台框架，可支持iOS和Mac OSX；CALayer也是整个图层类的基础，是所有核心动画图层的父类，使用CoreAnimation开发动画的本质就是将CALayer中的内容转化为位图再供硬件操作，drawRect的本质也是将图绘制到了UIView的layer中；在iOS中CALayer的设计主要是为了内容展示和动画操作，它本身并不包含在UIKit中，所以不能响应事件。
 
 CALayer：动画主作用层
 CAAnimation：核心动画的基础类，抽象类，不能直接使用，负责动画运行时间、速度的控制，本身实现了CAMediaTiming协议。
 CAAnimationGroup：动画组，一种组模式设计，可以并发执行若干动画效果。
 CAPropertyAnimation：属性动画的基类，也是个抽象类，本身不具备动画效果，只有子类才有。
 CATransition 转场动画，界面之间跳转（切换），主要通过滤镜进行动画效果设置。
 CABaseAnimation：基础动画，通过修改属性进行动画参数控制，只有初始状态和结束状态。
 CAKeyFrameAnimation：关键帧动画，同样是通过属性进行动画参数控制，但与CABaseAnimation不同的是它可以有多个状态控制。
 CASpringAnimation：弹簧动画。
 
 
 
 */


@interface TestAnimationViewController ()

@property (strong, nonatomic) IBOutlet UIButton *btn_tar;
@property (strong, nonatomic) IBOutlet UIButton *btn_go;

- (IBAction)btn_anim:(UIButton *)sender;

@end

@implementation TestAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}



- (IBAction)btn_anim:(UIButton *)sender {
//    CABasicAnimation *ani = [self rotationAnimation];
//    [_btn_tar.layer addAnimation:ani forKey:nil];
    
    CABasicAnimation *ani = [self scaleAnimation];
    [_btn_tar.layer addAnimation:ani forKey:nil];
    
   
}

#pragma mark - CABasicAnimation
//圆角变化
- (CABasicAnimation *)radiusAni{
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    ani.toValue = @25;
    ani.repeatCount = MAXFLOAT;
    ani.duration = 1;
    return ani;
}


// 颜色变化
- (CABasicAnimation *)colorAnimation{
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    ani.toValue = CFBridgingRelease([UIColor blueColor].CGColor);
    ani.repeatCount = MAXFLOAT;
    ani.duration = 1;
    return ani;
}

//旋转动画
- (CABasicAnimation *)rotationAnimation{
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //    baseAnimation.fromValue = @M_PI;
    //旋转弧度
    ani.toValue = @(M_PI * 2);
    //    baseAnimation.byValue = @M_PI_2;
    //设置动画重复次数
    ani.repeatCount = MAXFLOAT;
    //动画执行时间
    ani.duration = 1;
    return ani;
}

//缩放动画
- (CABasicAnimation *)scaleAnimation{
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    scale.fromValue = @0;
    ani.toValue = @1.2;
    ani.repeatCount = MAXFLOAT;
    ani.duration = 1;
    return ani;
}


-(void)anim{
    CAAnimation *animation = [CAAnimation animation];
    //动画持续时间
    animation.duration = 1;
    //动画重复次数
    animation.repeatCount = 1;
    //动画重复时间
    animation.repeatDuration = 2;
    /**
     默认YES，代表动画执行完毕后就从涂层上移除，图形会恢复到动画执行前状态；
     如果想让图层保持执行后状态，则设置为NO，此外还需设置fillMode为KCAFillModeForwards
     */
    animation.removedOnCompletion = YES;
    /**
     动画延时执行时间，若想延迟2s后执行，则设置CACurrentMediaTime()+2，
     * CACurrentMediaTime()：是coreAnimation的一个全局时间概念，指代图层当前时间
     */
    animation.beginTime = CACurrentMediaTime() + 2;
    /**
     决定当前对象在非active时间段的行为，比如动画开始之前,动画结束之后
     * KCAFillModeRemoved：默认值，动画开始前和结束后都对layer没任何影响，动画结束后layer会恢复到之前状态；
     * KCAFillModeForwards：当动画结束后，layer会一直保持结束后的状态；
     * KCAFillModeBackwards：在动画开始前，只要将动画加入layer，layer便会立即进入动画初始状态并等待动画开始；
     * KCAFillModeBoth：上两个的合成-动画加入layer后，layer会立即进入初始状态，动画结束后，layer会保持动画结束后状态
     */
    animation.fillMode = kCAFillModeRemoved;//默认值
    /**
     动画缓冲函数，速度函数
     * kCAMediaTimingFunctionLinear//匀速的线性计时函数
     * kCAMediaTimingFunctionEaseIn//缓慢加速，然后突然停止
     * kCAMediaTimingFunctionEaseOut//全速开始，慢慢减速
     * kCAMediaTimingFunctionEaseInEaseOut//慢慢加速再慢慢减速
     * kCAMediaTimingFunctionDefault//也是慢慢加速再慢慢减速，但是它加速减速速度略慢
     */
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //代理
    // animation.delegate = self;
    
    /*
     
     removeOnCompletion和fillMode都有影响动画结束状态的作用，而且两者之间还存在着一定的关联关系，那么他们之间又有什么区别和联系呢？
     动画执行完后恢复到执行前状态：
     
     removedOnCompletion = YES;
     动画执行完后保持执行后状态：
     
     
     removedOnCompletion = NO;
     fillMode = kCAFillModeForwards;//必须设置
     
     fillMode是指动画非active时间段的行为，即开始前或结束后，kCAFillModeForwards是在动画开始之后layer迅速进入指定位置开始执行动画并在removedOnCompletion = NO的前提下会停在动画结束的最后位置，而kCAFillModeBackwards则是在动画开始之前迅速进入指定状态并在动画开始后执行动画，动画结束后迅速返回到layer的本身位置
     kCAFillModeBoth是kCAFillModeForwards和kCAFillModeBackwards的集合，所以kCAFillModeBoth就很好理解了，如果removedOnCompletion = NO那layer会在动画开始之前就会迅速进入动画的初始位置并在执行完动画后停在动画结束的位置，如果removedOnCompletion = YES那layer会在动画开始之前就会迅速进入动画的初始位置并在执行完动画后迅速返回到layer的本身位置
     
     
     动画结束后想停在最后位置状态而非初始化状态的解决方案
     
     animation.removedOnCompletion = NO;
     animation.fillMode = kCAFillModeForwards;
     必须设置“removedOnCompl
     
     必须要注意的点
     @property(nullable, strong) id <CAAnimationDelegate> delegate;
     大家也应该注意到了，动画的代理属性是strong强类型，这点一定要注意，这就意味着在使用代理函数的时候有极大风险会造成循环引用问题，所以在动画结束后下次使用前一定要将当前动画移除
     
     CAPropertyAnimation
     CAPropertyAnimation，父类是CAAnimation，本身也是一个抽象类，自身并不能对layer进行动画操作，需要其子类CABasicAnimation和CAKeyframeAnimation来实现动画。
     属性介绍：
    //指定接收层动画的关键路径（下文有讲）
    @property(nullable, copy) NSString *keyPath;
    //如何处理多个动画在同一时间段执行的结果，若为true，同一时间段的动画合成为一个动画，默认为false。（使用 CAKeyframeAnimation 时必须将该属性指定为 true ，否则不会出现期待的结果）
    @property(getter=isAdditive) BOOL additive;
    //该属性指定动画是否为累加效果，下一次动画执行是否接着刚才的动画，默认为false
    @property(getter=isCumulative) BOOL cumulative;
    //该属性值是一个CAValueFunction对象，该对象负责对属性改变的插值计算，系统已经提供了默认的插值计算方式，因此一般无须指定该属性。
    @property(nullable, strong) CAValueFunction *valueFunction;
     
    KeyPath介绍：
    // CATransform3D Key Paths
    // 旋转x,y,z分别是绕x,y,z轴旋转
    static NSString *kCARotation = @"transform.rotation";
    static NSString *kCARotationX = @"transform.rotation.x";
    static NSString *kCARotationY = @"transform.rotation.y";
    static NSString *kCARotationZ = @"transform.rotation.z";
    
    //  缩放x,y,z分别是对x,y,z方向进行缩放
    static NSString *kCAScale = @"transform.scale";
    static NSString *kCAScaleX = @"transform.scale.x";
    static NSString *kCAScaleY = @"transform.scale.y";
    static NSString *kCAScaleZ = @"transform.scale.z";
    
    //  平移x,y,z同上
    static NSString *kCATranslation = @"transform.translation";
    static NSString *kCATranslationX = @"transform.translation.x";
    static NSString *kCATranslationY = @"transform.translation.y";
    static NSString *kCATranslationZ = @"transform.translation.z";
    
    //  平面
    // CGPoint中心点改变位置，针对平面
    static NSString *kCAPosition = @"position";
    static NSString *kCAPositionX = @"position.x";
    static NSString *kCAPositionY = @"position.y";
    
    //  CGRect
    static NSString *kCABoundsSize = @"bounds.size";
    static NSString *kCABoundsSizeW = @"bounds.size.width";
    static NSString *kCABoundsSizeH = @"bounds.size.height";
    static NSString *kCABoundsOriginX = @"bounds.origin.x";
    static NSString *kCABoundsOriginY = @"bounds.origin.y";
    
    // 透明度
    static NSString *kCAOpacity = @"opacity";
    // 背景色
    static NSString *kCABackgroundColor = @"backgroundColor";
    // 圆角
    static NSString *kCACornerRadius = @"cornerRadius";
    // 边框
    static NSString *kCABorderWidth = @"borderWidth";
    // 阴影颜色
    static NSString *kCAShadowColor = @"shadowColor";
    // 偏移量CGSize
    static NSString *kCAShadowOffset = @"shadowOffset";
    // 阴影透明度
    static NSString *kCAShadowOpacity = @"shadowOpacity";
    // 阴影圆角
    static NSString *kCAShadowRadius = @"shadowRadius";
    
     
     CABasicAnimation
     CABasicAnimation是核心动画类簇中的一个类，其父类是CAPropertyAnimation，其子类是CASpringAnimation，它的祖父是CAAnimation。它主要用于制作比较单一的动画，即不考虑中间变换过程，只考虑起点与目标变化，例如，平移、缩放、旋转、颜色渐变、边框的值的变化等，也就是将layer的某个属性值从一个值到另一个值的变化。类似x -> y这种变化，但是对于x -> y -> z甚至更多的变化是不行的。
     常用属性：
     //KeyPath相应属性的初始值
     @property(nullable, strong) id fromValue;
     //KeyPath相应属性的结束值
     @property(nullable, strong) id toValue;
     //KeyPath相应属性的初始值的改变值
     @property(nullable, strong) id byValue;
     很明显，fromvalue表示初始状态，tovalue表示最终状态，byvalue是在fromvalue的基础上发生的变化，这个可以慢慢测试，主要还是from和to。
     
     
     CAKeyFrameAnimation
//     关键帧动画，CApropertyAnimation的子类，，也是通过属性定义动画类型，其通过一组动画类型的值（或者一个指定的路径）和这些值对应的时间节点以及各时间节点的过渡方式来控制显示的动画。关键帧动画可以通过path属性和values属性来设置动画的关键帧。
//     它与CABaseAnimation的不同在于后者只局限于始末状态，但前者可以定义多个状态，让你的动画更灵活。

//
//     就是上述的NSArray对象。
//     里面的元素称为”关键帧”(keyframe)。
//     动画对象会在指定的时间(duration)内，依次显示values数组中的每一个关键帧
//     起点必须为values的第一个值。
//    @property(nullable, copy) NSArray *values;
//
//
//     作用与values属性一样，同样是用于指定整个动画所经过的路径的。
//     需要**注意**的是，values与path是互斥的，
//     当values与path同时指定时，path会覆盖values。
//     path只对CALayer的anchorPoint和position起作用。
//     如果你设置了path，那么values将被忽略
//    @property(nullable) CGPathRef path;
//
//
//     该属性是一个数组，用于指定每个子路径的时间，
//     可以为对应的关键帧指定对应的时间点,其取值范围为0到1.0,
//     keyTimes中的每一个时间值都对应values中的每一帧.
//     当keyTimes没有设置的时候,各个关键帧的时间是平分的。
//     如果指定值，则首尾必须为0和1
//    @property(nullable, copy) NSArray<NSNumber *> *keyTimes;
//
//
//     这个属性用以指定时间函数，类似于运动的加速度，有以下几种类型
//     * kCAMediaTimingFunctionLinear//线性
//     * kCAMediaTimingFunctionEaseIn//淡入
//     * kCAMediaTimingFunctionEaseOut//淡出
//     * kCAMediaTimingFunctionEaseInEaseOut//淡入淡出
//     * kCAMediaTimingFunctionDefault//默认
//
//     注意：这是一个数组，你有几个子路径就应该传入几个元素
//    @property(nullable, copy) NSArray<CAMediaTimingFunction *> *timingFunctions;
//
//
//     calculationMode 规定了关键帧之间的值如何计算，是控制关键帧动画时间的另一种方法。
//     * kCAAnimationLinear：默认值，线性过渡，快速回转到初始状态
//     * kCAAnimationDiscrete：离散运动，从一个帧直接跳跃到另一个帧，注意是直接跳跃，无过渡
//     * kCAAnimationPaced：向被驱动的方向施加一个恒定的力，以恒定速度运动，此时keyTimes和timingFunctions无效
//     * kCAAnimationCubic：对关键帧为座标点的关键帧进行圆滑曲线相连后插值计算,是使得运行的轨迹变得圆滑
//
//     * kCAAnimationCubicPaced：在kCAAnimationCubic的基础上使得动画运行变得均匀,就是系统时间内运动的距离相同,此时keyTimes以及timingFunctions也是无效的
//
//    @property(copy) CAAnimationCalculationMode calculationMode;
//
//
//     对于具有三次计算模式的动画，这些属性提供对插值方案的控制。 每个关键帧可能具有与之关联的张力，连续性和偏差值，每个都在[-1,1]范围内（这定义了Kochanek-Bartels样条，请参阅http://en.wikipedia.org/wiki/Kochanek-Bartels_spline）。
//     // 张力值控制曲线的“紧密度”（正值更紧，负值更圆）。 连续性值控制段的连接方式（正值给出尖角，负值给出倒角）。 偏差值定义曲线发生的位置（正值在控制点之前移动曲线，负值在控制点之后移动它）。
//     //每个数组中的第一个值定义第一个控制点的切线的行为，第二个值控制第二个点的切线，依此类推。 任何未指定的值都默认为零（如果未指定所有值，则给出Catmull-Rom样条曲线）。
//
//
//     动画的张力，当动画为立方计算模式的时候此属性提供了控制插值，
//     因为每个关键帧都可能有张力所以连续性会有所偏差它的范围为[-1,1]
//    @property(nullable, copy) NSArray<NSNumber *> *tensionValues;
//
//     动画的连续性值
//    @property(nullable, copy) NSArray<NSNumber *> *continuityValues;
//
//     动画的偏斜率
//    @property(nullable, copy) NSArray<NSNumber *> *biasValues;
//
//    /* Defines whether or objects animating along paths rotate to match the
//     * path tangent. Possible values are `auto' and `autoReverse'. Defaults
//     * to nil. The effect of setting this property to a non-nil value when
//     * no path object is supplied is undefined. `autoReverse' rotates to
//     * match the tangent plus 180 degrees.
//
//     默认nil
//     它有两种可选值：
//     * kCAAnimationRotateAuto：自动旋转
//     * kCAAnimationRotateAutoReverse：自动倒转
//     如果这个属性设置成以上两个值中的任意一个，当前layer都会始终保持朝向运动方向，也就是跟随运动方向自动旋转
//     当没有设置路径的时候我们用此属性的话也是可行的
//     一般配合path使用
//    @property(nullable, copy) CAAnimationRotationMode rotationMode;
    
     
     
     
    */
}
@end
