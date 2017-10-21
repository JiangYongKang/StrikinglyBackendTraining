class SuperClass
  module Foo
  end
end

# 在子类中，可以访问父类中定义的 module
class Subclass < SuperClass
  puts Foo #=> SuperClass::Foo
end
