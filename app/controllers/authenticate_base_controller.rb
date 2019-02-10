class AuthenticateBaseController < ApplicationController
  before_action :authenticate_accountant!
end
