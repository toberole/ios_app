// 快捷键
// cmd + alt + 左方向
// 折叠代码
// cmd + alt + 左方向
// 展开代码
// cmd + alt + 右方向



// 解析json
/*
 
 NSJSONReadingMutableContainers：
    返回可变容器，NSMutableDictionary或NSMutableArray。
 
 NSJSONReadingMutableLeaves：
    返回的JSON对象中字符串的值为NSMutableString
 
 NSJSONReadingAllowFragments：
    允许JSON字符串最外层既不是NSArray也不是NSDictionary，
 但必须是有效的JSON Fragment。例如使用这个选项可以解析 @“123” 这样的字符串。
 
 
 //判断类中是否包含某个方法的实现
 BOOL class_respondsToSelector(Class cls, SEL sel)
 //获取类中的方法列表
 Method *class_copyMethodList(Class cls, unsigned int *outCount)
 //为类添加新的方法,如果方法该方法已存在则返回NO
 BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types)
 //替换类中已有方法的实现,如果该方法不存在添加该方法
 IMP class_replaceMethod(Class cls, SEL name, IMP imp, const char *types)
 //获取类中的某个实例方法(减号方法)
 Method class_getInstanceMethod(Class cls, SEL name)
 //获取类中的某个类方法(加号方法)
 Method class_getClassMethod(Class cls, SEL name)
 //获取类中的方法实现
 IMP class_getMethodImplementation(Class cls, SEL name)
 //获取类中的方法的实现,该方法的返回值类型为struct
 IMP class_getMethodImplementation_stret(Class cls, SEL name)
 
 //获取Method中的SEL
 SEL method_getName(Method m)
 //获取Method中的IMP
 IMP method_getImplementation(Method m)
 //获取方法的Type字符串(包含参数类型和返回值类型)
 const char *method_getTypeEncoding(Method m)
 //获取参数个数
 unsigned int method_getNumberOfArguments(Method m)
 //获取返回值类型字符串
 char *method_copyReturnType(Method m)
 //获取方法中第n个参数的Type
 char *method_copyArgumentType(Method m, unsigned int index)
 //获取Method的描述
 struct objc_method_description *method_getDescription(Method m)
 //设置Method的IMP
 IMP method_setImplementation(Method m, IMP imp)
 //替换Method
 void method_exchangeImplementations(Method m1, Method m2)
 
 //获取SEL的名称
 const char *sel_getName(SEL sel)
 //注册一个SEL
 SEL sel_registerName(const char *str)
 //判断两个SEL对象是否相同
 BOOL sel_isEqual(SEL lhs, SEL rhs)
 
 //通过块创建函数指针,block的形式为^ReturnType(id self,参数,...)
 IMP imp_implementationWithBlock(id block)
 //获取IMP中的block
 id imp_getBlock(IMP anImp)
 //移出IMP中的block
 BOOL imp_removeBlock(IMP anImp)
 
 //调用target对象的sel方法
 id objc_msgSend(id target, SEL sel, 参数列表...)
 
  __block,__weak,__strong
 __block
 在 block 里面可以访问局部变量，但是不能修改局部变量，这是因为当局部变量在 block 中使用时，实际上是使用的变量在 block 中复制的数据，所以在 block 中修改的变量并不能修改 block 外面的变量值。这里要注意的是可变数组或者字典在 block 中添加或删除数据的时候，并不用 _block 修饰，因为在 block 里面使用这些数组的时候，数组的指针并没有发生变化，仅仅是内存的内容发生了变化
 
 __weak
 在 block 中，block 会对其对象强引用，对于 self 也会形成强引用，而 self 本身对于 block 也是强引用的，这样就会造成循环引用，这时候就需要用 __weak 打破这种循环，使对象弱引用。或者在 block 执行完后，将 block 置为 nil 也可以打破循环引用，但是这样做的话，block 只会执行一次，要是再次使用的话，就要重新赋值
 
 使用 __weak 打破循环的方法只在 ARC 下才有效，早 MRC 下应该使用 __block
 
 关于 _block 在 MRC 和 ARC 模式下的区别
 
 _block 在 MRC 下有两个作用
 1，允许在 block 内访问和修改局部变量
 2，禁止 block 对所引用的对象进行隐式 strong 操作
 _block 在 ARC 下的作用
 1，允许在block 内访问和修改局部变量
 
 下面是一些在 block 里面不需要使用 __weak 的情况:
 
 系统的大部分 GCD 方法
 
 这里是因为，block 作为参数传递给 GCD 时，系统会将 block 拷贝到堆上，而且 block 会持有 block 中用到的对象，并不是 self 持有，为了确保系统执行 block 中的任务时，其对象没有被意外释放掉，GCD 必须自己 strong 一次自己的对象，任务完成后在 release 掉，如果这里使用了 __weak 那么 GCD 就不会增加对象的引用计数，这样就造成在 block 访问起对象时，对象有可能已经被释放掉了
 
 大部分的 UIView 动画
 
 这里是因为 block 本身并不是被 self 持有，而是被 UIView 持有，并不会产生循环引用，当动画结束时，UIView 会释放掉 block ，block 会释放它持有的 self
 
 __strong
 在有些情况下，block 里面的 self 会被多次引用，这时候如果第一次引用后，因为时弱引用的状态，又可能 self 就会被释放掉，为了防止这种情况出现，就需要在 block 中先用 __strong 修饰一下 self
 
 即：如果在 block 中单次访问 self 或者 变量，只在外部使用一次 __weak 修饰 self 或者变量即可，如果要在 block 中多次访问 self 或者变量，则不仅要在外部用 __weak 修饰，在内部也要用 __strong 修饰一次。如果涉及到要修改变量，则要在外部用 __block 修饰 (ARC)
 
 
 iOS开发小技巧之--weakself宏
 防止如block的循环引用时，会使用__weak关键字做如下定义：
 __weak typeof(self) weakSelf = self;

 为了方便，不用每次都要写这样一句固定代码，定义了宏
 #define WeakSelf __weak typeof(self) weakSelf = self;
 在需要的地方使用：
 WeakSelf;
 ...
 [weakSelf doSomething];
 
 不止self需要使用weak，可能有部分变量也需要weak，于是我们的宏继续进化，不仅仅只支持self：
 
 #define WeakObj(o) __weak typeof(o) o##Weak = o;
 这样，后续对需要使用weak的对象，只要写一句WeakObj(obj)即可使用objWeak变量
 
 可以让我们的这个宏看起来更原生一些，我们添加了@符号在前面：
 #define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
 使用上看起来是这样
 @WeakObj(self);
 ...
 [selfWeak doSomething];
 
 其实还可以利用@try{}@finally{}这个也可以达到相同的效果，比如：
 
 #define WeakObj(o) try{}@finally{} __weak typeof(o) o##Weak = o;
 这部分空的@try或者空的@autoreleasepool会在编译时被优化掉，不必担心性能问题。
 相应的strong宏如下:
 
 #define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;
 使用例子如下:
 
 @WeakObj(self);
 [var setBlock:^{
 @StrongObj(self);
 [self doSomething];
 }];
 
 +load 方法是当类或分类被添加到 Objective-C runtime 时被调用的，实现这个方法可以让我们在类加载的时候执行一些类相关的行为。子类的 +load 方法会在它的所有父类的 +load 方法执行之后执行，而分类的 +load 方法会在它的主类的 +load 方法执行之后执行。但是不同的类之间的 +load 方法的调用顺序是不确定的。
 
 原因就在这里，因为加载顺序是父类先+load，然后子类+load，然后分类+load，那么如果分类重写子类方法：首先子类+load，将方法添加到类的方法列表methodLists，然后分类+load，将重写的方法添加到方法列表中，
 
 
 多个category实现同一个方法
 但是如果多个分类同时重写同一个方法，执行顺序又是怎样的呢？
 
 答案是：对于多个分类同时重写同一个方法，Xcode在运行时是根据buildPhases->Compile Sources里面的顺序从上至下编译的，那么很明显就像子类和分类一样，后编译的后load，即后添加到方法列表，所以后编译的分类，方法会放到方法列表顶部，调用的时候先执行。
 
 
 
 */


