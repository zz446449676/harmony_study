// 路由模块
import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State message: string = 'Hello Yikw'

  build() {
    Row() {
      Column() {

        Text(this.message)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)

        // 添加按钮
        Button() {
          Text('这是一个按钮')
            .fontSize(23)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({
          top: 20
        })
        .backgroundColor('#0D9FFB')
        .width('55%')
        .height('5%')
        // 跳转按钮绑定onClick事件，点击后跳转到 Second Page
        .onClick(() => {
          console.info(`Succeeded in clicking the 'Next' button.`)
          router.pushUrl({url: 'pages/Second'}).then(() => {
            console.info('Succeeded in jumping to the second page.')
          }).catch((err) =>{console.error(`Failed to jump to the second page.Code is ${err.code}, message is ${err.message}`)})
        })

      }
      .width('100%')
    }
    .height('100%')
  }
}