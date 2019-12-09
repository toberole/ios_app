#import "OCBaseViewController.h"
#import "../bean/Book.h"
// message.h包含了objc.h和runtime.h
#import <objc/message.h>

#import "../bean/Extra.h"
#import "../bean/Extra+Test.h"

// 用与移除KVO 可以用于区别子类和父类中的kvo观察者
// 移除的时候 子类 和 父类 分别移除自己的kvo观察者
NSString * const desc_context_kov = @"desc_context_kov";

@interface OCBaseViewController ()

@property(nonatomic,strong) UIButton * btn_block;
@property(nonatomic,strong) UIButton * btn_kvc_kvo;
@property(nonatomic,strong) UIButton * btn_kvo;
@property(nonatomic,strong) UIButton * btn_NSNotification;
@property(nonatomic,strong) Book *book_kvo;
@property(nonatomic,strong) Book *book_kvo1;
@property(nonatomic,strong) UIButton * btn_runtime;

@end

@interface DataTest:NSObject

@end

@interface DataTest ()
@property(nonatomic ,assign) int age;
@end
@implementation DataTest

@end

@implementation OCBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"OC Base";
    [self initViews];
    [self initData];
    NSLog(@"_book_kvo = %@",_book_kvo);
    
    [self addObserver4book_kvo];
    [self initNotificationCenter];
    
    NSLog(@"OCBaseViewController#viewDidLoad");
}

-(void)initViews{
    _btn_block = [self.view viewWithTag:1];
    NSLog(@"%@",self.btn_block);
    [_btn_block addTarget:self action:@selector(btn_block_clicked) forControlEvents:UIControlEventTouchUpInside];
    _btn_kvc_kvo = [self.view viewWithTag:2];
    [_btn_kvc_kvo addTarget:self action:@selector(btn_kvc_kvo_clicked) forControlEvents:UIControlEventTouchUpInside];
    _btn_kvo = [self.view viewWithTag:3];
    [_btn_kvo addTarget:self action:@selector(btn_kvo_clicked) forControlEvents:UIControlEventTouchUpInside];
    _btn_NSNotification = [self.view viewWithTag:4];
    [_btn_NSNotification addTarget:self action:@selector(btn_NSNotification_clicked) forControlEvents:UIControlEventTouchUpInside];
    _btn_runtime = [self.view viewWithTag:5];
    [_btn_runtime addTarget:self action:@selector(btn_runtime_clicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initData{
    _book_kvo = [[Book alloc]init];
    _book_kvo.name = @"init data book name";
    _book_kvo.price = 666;
    _book_kvo.desc = @"init data book desc";
    
    _book_kvo1 = [[Book alloc]init];
    _book_kvo1.name = @"init data book1 name";
    _book_kvo1.price = 666;
    _book_kvo1.desc = @"init data book1 desc";
}

#pragma mark - runtime
-(void)btn_runtime_clicked{
    NSLog(@"btn_runtime_clicked");
    
    // 通过类名称来实例化对象
    Class clazz = NSClassFromString(@"Book");
    Book *b = [[clazz alloc]init];
    b.name = @"name xxx";
    NSLog(@"b = %@",b);
    
    // 获取类
    Class clazz1 = [Book class];
    NSLog(@"Book class name = %@",NSStringFromClass(clazz1));
    
    // SEL 反射
    SEL selector = NSSelectorFromString(@"setName:");
    [b performSelector:selector withObject:@"name aaa"];
    NSLog(@"b = %@",b);
    
    // 将方法变成字符串
    SEL selector1 = NSSelectorFromString(@"setName:");
    NSString *selectorName = NSStringFromSelector(selector1);
    NSLog(@"selectorName: %@", selectorName);
    
    // class方法和objc_getClass方法
    /*
     判断对象类型:
     -(BOOL) isKindOfClass: 判断是否是这个类或者这个类的子类的实例
     -(BOOL) isMemberOfClass: 判断是否是这个类的实例
     
     判断对象or类是否有这个方法
     -(BOOL) respondsToSelector: 判读实例是否有这样方法
     +(BOOL) instancesRespondToSelector: 判断类是否有这个方法
     
     object_getClass:获得的是isa的指向
     self.class:当self是实例对象的时候，返回的是类对象，否则则返回自身。
     类方法class，返回的是self，所以当查找meta class时，需要对类对象调用object_getClass方法
     
     */
    
    /*
     OC 与 C 的对应方法
     [People class] == objc_getClass("People")
     @selector() == sel_registerName()
     */
    
    // runtime交换方法
    /*
     用法
     先给要替换的方法的类添加一个Category，然后在Category中的+(void)load方法中添加Method Swizzling方法，我们用来替换的方法也写在这个Category中。
     
     由于load类方法是程序运行时这个类被加载到内存中就调用的一个方法，执行比较早，并且不需要我们手动调用。
     
     注意要点
     Swizzling应该总在+load中执行
     Swizzling应该总是在dispatch_once中执行
     Swizzling在+load中执行时，不要调用[super load]。如果多次调用了[super load]，可能会出现“Swizzle无效”的假象。
     为了避免Swizzling的代码被重复执行，我们可以通过GCD的dispatch_once函数来解决，利用dispatch_once函数内代码只会执行一次的特性。
     方案1
         class_getInstanceMethod(Class _Nullable cls, SEL _Nonnull name)
         method_getImplementation(Method _Nonnull m)
         class_addMethod(Class _Nullable cls, SEL _Nonnull name, IMP _Nonnull imp,
         const char * _Nullable types)
         class_replaceMethod(Class _Nullable cls, SEL _Nonnull name, IMP _Nonnull imp,
         const char * _Nullable types)
     方案2
        method_exchangeImplementations(Method _Nonnull m1, Method _Nonnull m2)
     */
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{// dispatch_once app整个生命周只会执行一次
        // 方法一 没有在load方法里面实现
//        [Extra oneSwizzleInstanceMethod:@selector(test) withMethod:@selector(test_xxx)];
//        Extra *e_ch = [Extra new];
//        [e_ch test_xxx];
//        [e_ch test];
        
        // 方法二 在load里面实现交换
        Extra *e_ch = [[Extra alloc]init];
        NSLog(@"调用test_Extra");
        [e_ch test_Extra];
        NSLog(@"调用test");
        [e_ch test];
        
    });
    // runtime动态添加方法
    // runtime给分类添加属性
    
    // 分类重写主类的方法
    /*
     方法列表里会存在两个SEL相同的方法。
     实际调用时，调用的是后添加的方法，即后添加的方法在方法列表methodLists的这个数组的顶部
     类的加载顺序，决定方法的添加顺序，调用的时候，后添加的方法会先被找到，所以调用的始终是后加载的类的方法实现。
     */
    NSLog(@"分类重写主类的方法");
    id LenderClass = objc_getClass("Extra");
    unsigned int outCount, i;
    //获取实例方法列表
    Method *methodList = class_copyMethodList(LenderClass, &outCount);
    for (i=0; i<outCount; i++) {
        Method method = methodList[i];
        NSLog(@"instanceMethod：%@", NSStringFromSelector(method_getName(method)));
    }
    Extra *ex = [[Extra alloc]init];
    // 调用的是分类里面的方法
    [ex test_over];
}

-(void)initNotificationCenter{
    // selector 接收到消息的调用的方法
    // name 消息的标示 用于接收消息匹配
    // object 用于接收消息标示 与发消息的匹配 nil匹配所有
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notification_x:) name:book_notification object:nil];
}

-(void)notification_x:(NSNotification *)data{
    NSLog(@"接收到 notification_x data = %@",data);
}

-(void)addObserver4book_kvo{
    NSLog(@"OCBaseViewController#addObserver4book_kvo");
    // 注册观察者 KVO 在dealloc中可以移除
    // context 可以用来标记
    // 注意：使用 Class 方法获取的对象类型不是准确的，想要获取类的真实类型使用runtime 的 object_getClass（）函数
    NSLog(@"添加监听前Class info book_kvo = %@  book_kvo1= %@",object_getClass(self.book_kvo),object_getClass(self.book_kvo1));
    //self.book_kvo.isa
    NSLog(@"添加监听前Method info book_kvo = %p  book_kvo1= %p",[self.book_kvo methodForSelector:NSSelectorFromString(@"setDesc:")],[self.book_kvo1 methodForSelector:NSSelectorFromString(@"setDesc:")]);
    
    [self.book_kvo addObserver:self forKeyPath:@"desc" options:NSKeyValueObservingOptionOld context:(void*)desc_context_kov];
    NSLog(@"添加监听后Class info book_kvo = %@  book_kvo1= %@",object_getClass(self.book_kvo),object_getClass(self.book_kvo1));
    
    NSLog(@"添加监听后Method info book_kvo = %p  book_kvo1= %p",[self.book_kvo methodForSelector:NSSelectorFromString(@"setDesc:")],[self.book_kvo1 methodForSelector:NSSelectorFromString(@"setDesc:")]);
    
    [self.book_kvo addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld context:nil];
    [self.book_kvo addObserver:self forKeyPath:@"price" options:NSKeyValueObservingOptionOld context:nil];
}

-(void)removeObserver4book_kvo{
    NSLog(@"OCBaseViewController#removeObserver4book_kvo");
    // 注册观察者 KVO 在dealloc中可以移除
    // 定向移除 desc_context_kov
    [self.book_kvo addObserver:self forKeyPath:@"desc" options:NSKeyValueObservingOptionOld context:(void*)desc_context_kov];
    
    [self.book_kvo addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld context:nil];
    [self.book_kvo addObserver:self forKeyPath:@"price" options:NSKeyValueObservingOptionOld context:nil];
}

-(void)dealloc{
    // 当对同一个keypath进行两次removeObserver时会导致程序crash
    NSLog(@"OCBaseViewController#dealloc");
    [self.book_kvo removeObserver:self forKeyPath:@"desc"];
    [self.book_kvo removeObserver:self forKeyPath:@"name"];
    [self.book_kvo removeObserver:self forKeyPath:@"price"];
    
    // 移除notication
    [[NSNotificationCenter defaultCenter]removeObserver:self name:book_notification object:nil];
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"OCBaseViewController#viewDidLayoutSubviews");
}

-(void)btn_NSNotification_clicked{
    NSLog(@"btn_NSNotification_clicked");
    // 发送消息
    [_book_kvo notification_book];
}

-(void)btn_kvo_clicked{
    NSLog(@"...... btn_kvo_clicked ......");
    _book_kvo.name = @"btn_kvo_clicked kvo name";
    _book_kvo.desc = @"btn_kvo_clicked kvo desc";
    _book_kvo.price = _book_kvo.price + 1;
}

/*
 KVC
 基本使用
 setValue：forKey 和 setValue：forKeyPath两个方法
 setValue forkey 和 setValue forKeyPath 的区别在于，forKeyPath 是可以多深层次访问的。例如：有两个类 Psrson 和Student，Psrson 类里面有个Student 类型的对象，Student 类里面有个 score 属性。那么就可以这么使用：[person setValue:@80 forKeyPath:@"student.score" ]
 setValue设值顺序：
    查找setKey 方法，有则调用，没有则查找看有没有_setKey方法，有则调用。没有则查看 accessInstanceVariablesDirectly 这个类方法的返回值，是yes则按照_key 、_isKey 、key 、iskey 顺序查找成员变量。如果没有找到则抛出异常 NSUnknownKeyException 。如果accessInstanceVariablesDirectly返回值是 NO，则程序抛出异常
 valueForKey的取值顺序：
    先按照 getKey 、key 、isKey 、_key 顺序查找方法取值，如果没有找到方法则查看accessInstanceVariablesDirectly 类方法的返回值，如果返回的是 NO，则抛出异常。如果返回的是YES，按照_key 、_isKey 、key 、isKey 顺序查找成员变量，如果没有找到，则抛出异常。
 
 
 KVC: key value code 可以访问和修改私有成员变量、readOnly成员变量的值
 1、基本概念
 
 1）键-值编码是一个用于间接访问对象属性的机制，使用该机制不需要调用存取方法和变量实例就可以访问对象属性
 
 2）通过KVC可以给readonly的属性赋值，
 
 3）如果对象属性为基本数据类型时，我们存的时候需要将数据封装为NSNumber类型，系统内部存取时，系统会自动封装/解封
 
 4）如果没有用@property声明，他讲在内部查找名为_key或key的实例变量
 
 5）路径      除了通过键值设置值外，键/值编码还支持指定路径，通过.号隔开
 
 6）一对多的关系      如果向NSArray请求一个键值，它实际上会查询数组中的每个对象来查找这个键值，然后将查询结果打包到另一个数组中并返回给你。
 
 7）可以应用字符做简单运算，sum/min/max/avg/count
 
 8）存取值格式        存值          setValue:forKey:          setValue:forKeyPath:        取值          valueForKey:          valueForKeyPath:
 
 2、适用情况：将服务器的内容转化为数据模型，能够简化代码
 
 KVO: Key-Value-Observer
 1、基本概念      一种使对象获取其他独享的特定属性变化的通知机制
 
 2、适用情况      主要用于试图，交互方面，比如界面的某些数据变化了，界面的显示也需要跟着变化，就需要建立数据和界面的关联
 
 3、实现步骤
 
 1）采用下面这个方法给属性添加观察者,在哪里注册观察者就要在哪里移除观察者          - (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;      2）观察者实现下面方法，如果监听的属性发生变化，便会调用该方法。          - (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void *)context;
 
 3）个人习惯在delloc中释放
 
 - (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context;
 
 KVO原理
    当某个类的对象第一次被观察时，系统在运行时会创建该类的派生类，改派生类中重写了该对象的setter方法，并且在setter方法中实现了通知的机制。派生类
 写了class方法，以“欺骗”外部调用者他就是原先那个类。系统将这个类的isa指针指向新的派生类，因此改对象也就是新的派生类的对象了。因而改对象调用setter就会调用重写的setter，从而激活键值通知机制。此外派生类还重写了delloc方法来释放资源。
 1 iOS用什么方式实现对一个对象的KVO？（KVO的本质是什么？）
    当一个对象使用了KVO监听，iOS系统会修改这个对象的isa指针，改为指向一个全新的通过Runtime动态创建的子类，子类拥有自己的set方法实现，set方法实现内部会顺序调用willChangeValueForKey方法、原来的setter方法实现、didChangeValueForKey方法，而didChangeValueForKey方法内部又会调用监听器的observeValueForKeyPath:ofObject:change:context:监听方法。
 2 如何手动触发KVO
    被监听的属性的值被修改时，就会自动触发KVO。如果想要手动触发KVO，则需要我们自己调用willChangeValueForKey和didChangeValueForKey方法即可在不改变属性值的情况下手动触发KVO，并且这两个方法缺一不可。

 KVO的使用场景 KVO用于监听对象属性的改变。
 
 　　（1）下拉刷新、下拉加载监听UIScrollView的contentoffsize；
 
 　　（2）webview混排监听contentsize；
 
 　　（3）监听模型属性实时更新UI；
 
 　　（4）监听控制器frame改变，实现抽屉效果。
 
 kVO 实现原理总结：
 动态生成一个子类，让这个对象的isa 指针指向一个新的类
 当修改对象的属性时 会调用重写的setter 方法。这个 setter 方法内部是 先调willChangeValueForKey， 再调父类原来的setter方法，再调didChangeValueForKey，最后触发监听的回调方法
 
 
 三、通知的基本概念和用法
 
 1、基本概念
 
 1）一种一对多的信息广播机制，一个应用程序同时只能有一个NSNotificationCenter对象
 
 2）任何人都可以发送任何消息到消息中心，识别感兴趣通知的标示就是object＋通知名称
 
 2、适用情况
 
 类与类之间传递信息
 
 3、实现步骤
 
 1）添加通知
 
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySalary) name:@"发工资啦" object:nil];
 
 2）实现添加通知时方法选择器选择的方法
 
 3）在需要发送通知的类中采用下面方法发送通知，发送成功便会执行步骤二实现的方法
 
 [[NSNotificationCenter defaultCenter] postNotificationName:@"发工资啦" object:nil];
 
 4）移除通知
 
 [[NSNotificationCenter defaultCenter] postNotificationName:nil object:nil userInfo:nil];
 
 */

/*
 键值编码中基本使用-valueForKey:和-setValue:forKye:方法。
 可以像对象发送消息并且传递你想要访问的熟悉名称的键值作为参数。
 KVC方法会首先查找以参数命名的getter、setter方法，如果没有提供getter、setter方法，KVC方法会直接寻找_name和name的实例变量。
 
 */
#pragma mark kvc
-(void)btn_kvc_kvo_clicked{
    NSLog(@"btn_kvc_kvo_clicked");
    
    Book *book = [[Book alloc]init];
    book.name = @"test name1";
    NSLog(@"book = %@",book);
    
    Book *book1 = [[Book alloc]init];
    // kvc 赋值
    [book1 setValue:@"kvc setValue" forKey:@"name"];
    // kvc 赋值 注意基本数据类型 需要时NSNumber类型
    NSNumber *num = [NSNumber numberWithInt:100];
    [book1 setValue:num forKey:@"price"];
    NSLog(@"book1 = %@",book1);
    // 取值 valueForKey
    int price = [[book1 valueForKey:@"price"]intValue];
    NSLog(@"price = %i",price);
    // 取值 dictionaryWithValuesForKeys
    NSDictionary *dict = [book1 dictionaryWithValuesForKeys:@[@"name",@"price"]];
    NSLog(@"info = %@",dict);
    
    // 数组 valueForKey
    Book *book2 = [[Book alloc]init];
    book2.name = @"book2 name";
    book2.price = 100;
    Book *book3 = [[Book alloc]init];
    book3.name = @"book3 name";
    book3.price = 200;
    NSArray *arr = @[book2,book3];
    NSArray *names = [arr valueForKey:@"name"];
    NSLog(@"names = %@",names);
    
    // 带路径
    Book *book4 = [[Book alloc]init];
    book4.price = 400;
    book4.name = @"book4 name";
    NSString *book4_name = [book4 valueForKeyPath:@"name"];
    NSNumber *book4_price = [book4 valueForKeyPath:@"price"];
    NSLog(@"valueForKeyPath book4_name = %@,book4_price = %i",book4_name,[book4_price intValue]);
    
    // 带路径 访问内部对象信息
    Book *bookx = [[Book alloc]init];
    Extra *e = [[Extra alloc]init];
    e.extra_info = @"**** extra_info ****";
    bookx.extra = e;
    NSString *ee = [bookx valueForKeyPath:@"extra.extra_info"];
    NSLog(@"带路径 访问内部对象信息 %@",ee);

    
    // 字典转换为模型
    NSDictionary *dict1 = @{@"name":@"dict name",@"desc":@"dict desc",@"price":@333};
    Book *book5 = [[Book alloc]init];
    [book5 setValuesForKeysWithDictionary:dict1];
    NSLog(@"book5 = %@",book5);
    
}
//实现KVO方法
/**
 *  当监控的某个属性的值改变了就会调用
 *
 *  @param keyPath 属性名（哪个属性改了？）
 *  @param object  哪个对象的属性被改了？
 *  @param change  属性的修改情况（属性原来的值、属性最新的值）
 *  @param context void * == id
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"--------- observeValueForKeyPath ---------");
    
    if (YES/* 判断条件 */) {
        NSLog(@"observeValueForKeyPath keyPath = %@",keyPath);
        NSLog(@"observeValueForKeyPath object = %@",object);
        NSLog(@"observeValueForKeyPath change = %@",change);
        NSLog(@"observeValueForKeyPath context = %@",context);
    }else{
        // 注意给父类
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


/*
    block 访问外部的局部变量 不能修改且使用的使用的外部局部变量的拷贝
 */
-(void)btn_block_clicked{
    // block内不能修改
    int n = 1;
    // block 内部可以修改
    __block int k = 0;
    NSLog(@"n addr: %p",&n);
    
    DataTest *dataTest = [[DataTest alloc]init];
    dataTest.age = 11;
    NSLog(@"dataTest = %@",dataTest);
    
    void (^tb)() = ^(){
        NSLog(@"block n addr: %p",&n);
        
        NSLog(@"k = %i",k);
        k++;
        NSLog(@"k = %i",k);
        
        // 使用对象
        NSLog(@"block dataTest = %@",dataTest);
        NSLog(@"age = %i",dataTest.age);
        dataTest.age = 22;
        NSLog(@"age = %i",dataTest.age);
    };
    
    tb();
    
    NSLog(@"tb() age = %i",dataTest.age);
}


@end
