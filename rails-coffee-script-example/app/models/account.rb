class Account < ApplicationRecord
  enum status: [:enabled, :disabled]
end
