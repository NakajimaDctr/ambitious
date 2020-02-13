class ApplicationController < ActionController::Base
before_action :listall
  def listall
    @lists = List.all
  end
end
