# coding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  require 'will_paginate/array'

  def ajax_response
    respond_to do |format|
      format.json { render json: 'true' }
    end
  end

  def paginate(array, num)
    array.paginate :page => params[:page], :per_page => num
  end

  def admin_is_login
    merchant = Merchant.find_by(id: session[:user_id])
    admin = !merchant.nil? && merchant[:login_type] == 'admin'
    if ! admin
      redirect_to :login
    end
  end

  def user_is_login
    merchant=Merchant.find_by(id: session[:user_id])
    user = !merchant.nil? && merchant[:login_type] == 'user'
    if !user
      redirect_to :login
    end
  end

  def current_user
    Merchant.find_by(id:session[:user_id]) if session[:user_id]
  end

end
