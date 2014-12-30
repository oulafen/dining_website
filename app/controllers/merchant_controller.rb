# coding: utf-8
class MerchantController < ApplicationController

  before_filter :user_is_login, only: [:merchant_index,:save_merchant_modify_info,:dishes_management,
                                       :add_new_dish,:modify_dishes_info,:save_modify_dish_id]

  before_action :show_logo

  def show_logo
    @site_photo=SitePhoto.first
  end
  def login
    if !current_user.nil? && current_user[:login_type] == 'user'
      redirect_to :merchant_index
    end
    if !current_user.nil? && current_user[:login_type] == 'admin'
      redirect_to :admin_index
    end
  end

  def logout
    reset_session
    redirect_to :login
  end

  def create_login_session
    legal_merchant = Merchant.judge_login_input(params[:user])
    if !legal_merchant
      flash.now[:error] = '用户名或密码错误'
      render :login
    end
    if legal_merchant
      merchant=Merchant.find_by(user_name:params[:user][:user_name])
      if merchant[:status]=="checking"
        flash.now[:error] = '正在审核中'
        render :login
      else
        if cookies.permanent[:visitors_id]
          cookies.delete(:visitors_id)
        end
        session[:user_id] = legal_merchant.id
        redirect_to legal_merchant.login_type == 'user' ? :merchant_index : :admin_index
      end
    end
  end

  def merchant_index
      @addrs = Addr.where(:user_id => session[:user_id])
      @addr = Addr.new
      @merchant = current_user

      @time_to=@merchant[:time_to].to_s[11..19]
      @time_from=@merchant[:time_from].to_s[11..19]

      @selected_labels = MerchantLabel.get_merchant_labels(session[:user_id])
      @labels = site_dishstyle_labels
      @site_labels = paginate(Label.get_labels_by_category_id_and_create_type(1,current_user[:user_name]), 20)
      @dish_style_labels = paginate(Label.get_labels_by_category_id_and_create_type(2,current_user[:user_name]), 20)
      @taste_labels = paginate(Label.get_labels_by_category_id_and_create_type(3,current_user[:user_name]), 20)
      flash.now[:error] = ""
  end

  def add_new_label
    if Label.is_repeated(params[:label][:content],params[:label][:user_name])=="true"
      respond_to do |format|
        format.json { render json: {:repeated => "true"} }
      end
    else
      if params[:label][:category_id]==1
        if params[:label][:postcode].present?
          Label.create(:content=>params[:label][:content],:site=>params[:label][:site],:postcode=>params[:label][:postcode],:create_type=>params[:label][:user_name],:category=>params[:label][:category],:category_id=>params[:label][:category_id])
        else
          Label.create(:content=>params[:label][:content],:site=>params[:label][:site],:create_type=>params[:label][:user_name],:category=>params[:label][:category],:category_id=>params[:label][:category_id])
        end
      else
        Label.create(:content=>params[:label][:content],:create_type=>params[:label][:user_name],:category=>params[:label][:category],:category_id=>params[:label][:category_id])
      end
      respond_to do |format|
        format.json { render json: {:repeated => "false"} }
      end
    end
  end

  def site_dishstyle_labels
    paginate(Label.order('category_id').where(:category_id => 1) + Label.order('category_id').where(:category_id => 2), 50)
  end

  def save_merchant_modify_info
    @merchant = current_user
    @addrs = Addr.where(:user_id => session[:user_id])

    if params[:merchant][:href]&&params[:merchant][:href]!=""&&params[:merchant][:href][0..6]!="http://"
      go_render
      return
    end


    if ! params[:merchant][:restaurant_name]||!params[:merchant][:email]
      @selected_labels = MerchantLabel.get_merchant_labels(session[:user_id])
      @labels = site_dishstyle_labels
      @addr = Addr.new
      flash.now[:error] = '请将餐馆信息填写完整'
      render :merchant_index

    else

      Merchant.update_merchant_info(params,@merchant,@addrs,session[:user_id])
      session[:merchant_update_success] = 'true'
      redirect_to :merchant_index
    end
  end

  def delete_address
    Addr.find_by(id: params[:addr_id]).delete
    redirect_to :merchant_index
  end

  def save_address

  end

  def dishes_management
      clear_dish_sessions
      @dishes = paginate(Dish.where(:user_id => session[:user_id]), 10)
      @merchant = current_user
  end

  def clear_dish_sessions
    session[:add_dish_label_ids] = nil
    session[:success] = nil
    session[:modify_dish_id] = nil
  end

  def add_new_dish
      @selected_labels = DishLabel.get_add_dish_labels(session)
      @dish = Dish.new
      @merchant = current_user
      @dish_style_labels = paginate(Label.get_labels_by_category_id_and_create_type(2,current_user[:user_name]), 20)
      @taste_labels=paginate(Label.get_labels_by_category_id_and_create_type(3,current_user[:user_name]), 20)
  end

  def modify_dishes_info
      @selected_labels = DishLabel.get_dish_labels(session[:modify_dish_id])
      @dish = Dish.find_by(id: session[:modify_dish_id])
      @merchant = current_user
      @dish_style_labels = paginate(Label.order('category_id').where(:category_id=>2), 20)
      @taste_labels = paginate(Label.order('category_id').where(:category_id=>3), 20)
  end

  def save_modify_dish_id
      session[:modify_dish_id] = params[:id]
      redirect_to :modify_dishes_info
  end

  def update_dishes_info
    dish = Dish.find_by(id: session[:modify_dish_id])
    dish.update_attributes(params[:dish])
    session[:success] = 'true'
    redirect_to :modify_dishes_info
  end

  def save_new_dish
    Dish.create({:user_id => session[:user_id], :name => params[:dish][:name], :price => params[:dish][:price], :remark => params[:dish][:remark], :photo => params[:dish][:photo]})
    if session[:add_dish_label_ids]
      session[:add_dish_label_ids].each do |a|
        dish_id = Dish.where(:user_id => session[:user_id], :name => params[:dish][:name])[0].id
        DishLabel.create({:dish_id => dish_id, :label_id => a})
      end
    end
    redirect_to :dishes_management
  end

  def delete_dish
    Dish.find_by(id:params[:id]).delete
    redirect_to :dishes_management
  end

  def update_merchant_labels
    MerchantLabel.delete_all(:user_id => session[:user_id])
    if !params[:choose_label_ids].nil?
      params[:choose_label_ids].each do |id|
        MerchantLabel.create({:user_id => session[:user_id], :label_id => id})
      end
    end
    ajax_response
  end

  def update_modify_dish_labels
    DishLabel.delete_all(:dish_id => session[:modify_dish_id])
    if !params[:choose_label_ids].nil?
      params[:choose_label_ids].each do |id|
        DishLabel.create({:dish_id => session[:modify_dish_id], :label_id => id})
      end
    end
    ajax_response
  end

  def save_add_dish_labels
    session[:add_dish_label_ids] = params[:choose_label_ids]
    ajax_response
  end

  def go_render
    merchant_index
    flash.now[:error] = '输入正确网址'
    render :merchant_index
  end

end
