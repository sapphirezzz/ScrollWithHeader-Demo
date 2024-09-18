实现 SwiftUI 下，常见的带头部嵌套滚动效果的页面框架。

目前实现了两种方案，各有特点。

## 方案一

- 实现逻辑

监听页面手势，实时改变`header`的高度，手势停止时，修改`header`的高度为完全消失或完全出现两种情况。

根据`header`的高度情况设置页面是否可滚动。

- 特点
1. 手势发生停止后`header`会完全消失或完全出现，即类似自动吸附的效果；
2. 再进行手势操作，才会操作到页面的滚动；

https://github.com/user-attachments/assets/3359ecc9-8dc0-44a2-88b9-d455a21402af

## 方案二

- 实现逻辑

页面滚动时，回调页面框架，页面框架实时改变`header`的高度。

- 特点
1. `header`的滚动和页面的滚动协同；
2. `header`可停留在某个高度
3. 手势连续不会断开；

https://github.com/user-attachments/assets/54b22f7e-2a78-40d9-bedf-efacbc0ec1aa
