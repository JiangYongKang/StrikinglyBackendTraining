# Unit test framework minitest
```ruby
$ gem install minitest
```
```ruby
require 'minitest/autorun'

# 测试类必须继承 "Minitest::Test"
class TestAccount < Minitest::Test

  # 测试方法必须以 "test_" 开头
    def test_account

  end
end
```
