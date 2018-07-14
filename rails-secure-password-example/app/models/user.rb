class User < ApplicationRecord
  # 这会为 model 加上 password 和 password_confirmation 两个属性。
  # 这两个属性是 model 的一部分，但是并不存在于数据库中！
  # 因为我们并不需要存储明文密码
  has_secure_password

  # bcrypt 不会对密码的长度进行校验，我们需要自己验证密码长度
  validates :password, length: { minimum: 6 }

  # has_secure_password 还为 model 提供了 password_confirmation 属性。
  # 只有当该属性为非 nil 值时才触发验证。
  # 如果该属性非 nil，则其值必须与 password 属性相等
  validates_confirmation_of :password
end
