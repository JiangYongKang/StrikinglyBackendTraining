# Unit test framework rspec

## 安装
```ruby
group :development, :test do
  gem 'rspec-rails'
end
```
```zsh
$ bundle install
$ rails generate rspec:install # 设置让Rails使用RSpec 而不用Test::Unit
Running via Spring preloader in process 11448
      create  .rspec
      create  spec
      create  spec/spec_helper.rb # 设置测试的配置信息
      create  spec/rails_helper.rb
```
