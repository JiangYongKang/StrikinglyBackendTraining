# rails-coffee-script-example

在本文中，主要讲述如何在 Rails 项目中使用 CoffeeScript、Sass、jQuery 以及安装使用其他 JS 的第三方组件。

### 安装前端依赖
创建一个新的 rails 项目，本文中所用的 rails 版本是 5.2。
```console
$ rails -v
Rails 5.2.0
$ rails new example
....
```
在项目的根目录下，通过 npm 或者 yarn 将 JS 的依赖安装进来。由于 rails 已经自带了 CoffeeScript 和 Sass，所以这里只用安装 jQuery 即可。
```console
$ yarn add jquery
```
安装完毕，在项目的根目录中应该会有 package.json 和 yarn.lock 文件，它们看起来应该是这样的：
```json
{
  "name": "rails-coffee-script-example",
  "private": true,
  "dependencies": {
    "jquery": "^3.3.1"
  }
}
```
```
jquery@^3.3.1:
  version "3.3.1"
  resolved "http://r.cnpmjs.org/jquery/download/jquery-3.3.1.tgz#958ce29e81c9790f31be7792df5d4d95fc57fbca"
```
如果我们现在试图通过 `$` 调用 jQuery 的 api, 会得到一个错误。
```
Uncaught ReferenceError: $ is not defined
```
与常见的前端项目不同，rails 中添加前端的依赖之后，还需要执行与之对应的 rake 任务。才能将前端的第三方主键正确的添加进来。
```console
$ rails yarn:install
```
到这一步，前端的相关依赖已经正确的安装完毕，下面的内容将介绍 rails 中静态资源文件的加载方式。

### 资源的加载方式
Rails会自动的加载  `app/assets/javascripts/application.js` 与 `app/assets/stylesheets/application.css` 这两个文件。这两个文件去 require 其他的资源文件文件。这两个文件的内容如下：
```js
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require_tree .
```
```css
/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS and SCSS file within this directory, lib/assets/stylesheets, or any plugin's
 * vendor/assets/stylesheets directory can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the bottom of the
 * compiled file so the styles you add here take precedence over styles defined in any other CSS/SCSS
 * files in this directory. Styles in this file should be added after the last require_* statement.
 * It is generally better to create a new file per style scope.
 *
 *= require_tree .
 *= require_self
 */
```
`//= require` 和 `*= require` 并不是注释，而是导入其他资源文件的语句，这点很坑。
我们在通过 `rails` 脚手架生成 `controller` 的时候，会自动的创建同名的 `.coffee` 和 `.sass` 文件。通过 `require_tree .` 来引入到主资源文件中。

样例代码：[https://github.com/JiangYongKang/strikingly-self-training-demos/tree/master/rails-coffee-script-example](https://github.com/JiangYongKang/strikingly-self-training-demos/tree/master/rails-coffee-script-example)