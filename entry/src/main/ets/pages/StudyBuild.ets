// 该类用于学习装饰器相关的基础语法
// 入口装饰器 @Component装饰器仅能装饰struct关键字声明的数据结构。struct被@Component装饰后具备组件化的能力
@Entry
  // 组件装饰器 @Entry装饰的自定义组件将作为UI页面的入口。在单个UI页面中，最多可以使用@Entry装饰一个自定义组件
@Component
struct StudyBuild {
  // @State 装饰器表示数据状态，如果数据被改变，则会重新渲染组件
  @State message: string = 'Hello Yikw'

  // @Builder 将重复使用的UI元素抽象成一个方法，在build方法里调用。类似于Flutter里的一个方法 return 一个 Widget
  // 里面还有BuilderParam装饰器的用法，具体参考 https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/arkts-builderparam-0000001524416541-V3
  // 局部方法
  @Builder MyBuildComponent( $$ : { paramA : string}) { // ArkUI提供$$作为按引用传递参数的范式。 按引用传递参数时，传递的参数可为状态变量，且状态变量的改变会引起@Builder方法内的UI刷新。
    Column() {
      Text($$.paramA)
        .fontSize(40)
        .fontWeight(FontWeight.Bold)

      // 使用命名参数覆盖默认值
      MyText({text: "custom Text", fontSize: 60})
    }
  }

  build() {
    Column() {
      this.MyBuildComponent({paramA : this.message})
      Button('Click me').onClick(() =>{
        this.message = 'Yikw && zhang'
      })
    }
    .width('100%')
    .height('100%')
  }
}

// 全局方法
@Builder function MyBuildComponent() {
  Row() {
    Text(this.message)
      .fontSize(40)
      .fontWeight(FontWeight.Bold)
  }
}

// 自定义组件多样使用
@Component
struct MyText {
  @State text: string = "text"
  fontSize: number = 12
  fontWeight: FontWeight = FontWeight.Bold

  @Styles pressStyle() {
    .backgroundColor(Color.Red)
  }

  build() {
    Text(this.text)
      .fancy(this.fontSize, this.fontWeight)
      .stateStyles({
        normal: normalStyle,
        pressed: this.pressStyle,
      })
  }
}

// @Styles装饰器可以将多条样式设置提炼成一个方法，直接在组件声明的位置调用。通过@Styles装饰器可以快速定义并复用自定义样式。用于快速定义并复用自定义样式。
// 注意，不支持传入参数
// 支持全局和局部使用
@Styles function normalStyle() {
  .backgroundColor(Color.Blue)
}

// 定义扩展组件样式,示例中对Text组件进行拓展样式，用于简化代码，样式代码复用
// 和@Styles不同，@Extend仅支持定义在全局，不支持在组件内部定义。
// 和@Styles不同，@Extend支持封装指定的组件的私有属性和私有事件和预定义相同组件的@Extend的方法。
// 支持传入参数,可以传入回调方法
@Extend(Text) function fancy (fontSize: number, fontWeight: FontWeight) {
  .fontSize(fontSize)
  .fontWeight(fontWeight)
}