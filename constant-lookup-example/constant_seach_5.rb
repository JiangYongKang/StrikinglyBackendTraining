class Object
  module Foo
  end
end
# 直接定义的 module 直接被附加到 Object 中，所以这里也可以直接用 object::Foo 访问
# 这反过来说明了为什么顶级常量在整个程序中可用。Ruby中几乎所有的类继承自Object，
# 所以Object几乎总是包含在当前打开的类的祖先列表中，因此它的常量几乎总是可用。
module Bar
end
puts Object::Foo, Object::Bar #=> Foo Bar
