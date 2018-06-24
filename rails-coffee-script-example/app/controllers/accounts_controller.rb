class AccountsController < ApplicationController
  def index
    @accounts = Account.enabled
  end
end
