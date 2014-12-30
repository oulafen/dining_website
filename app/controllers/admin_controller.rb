# coding: utf-8
class AdminController < ApplicationController
  before_filter :admin_is_login ,  only:[:admin_index,:add_new_merchant,:save_modify_merchant_id,:modify_merchant_info,:roll_images_manager,:label_dish_style_list,:label_site_list,:label_flavour_list]
  before_action :show_logo

  def show_logo
    @site_photo=SitePhoto.first
  end
  def admin_index
      @merchant = current_user
      @checked_merchants=paginate(Merchant.get_checked_merchants,10)
      @checking_merchants=paginate(Merchant.where(:login_type => 'user',:status => "checking"),10)
  end

  def pass_check
    merchant=Merchant.find_by(user_name:params[:user_name])
    merchant[:status]="checked"
    merchant.save

    respond_to do |format|
      format.json {render json: {:email=>merchant[:email]}}
    end
  end

  def send_pass_check_email
    mail_to = params[:email]
    mail = Mail.new
    mail.charset = 'UTF-8'
    mail.content_transfer_encoding = '8bit'
    mail.from = 'dining_website'
    mail.to = "#{mail_to}"
    mail.subject = "餐馆注册审核通过通知"
    mail.text_part do
      body "恭喜通过审核"
    end
    mail.html_part do
      content_type 'text/html; charset=UTF-8'
      body '<h2>您的餐馆注册申请已通过，点击下面链接去完善您的餐馆信息吧</h2><br>
            <a href=http://www.eatparadise.com/login>http://www.eatparadise.com/login</a>'
    end
    mail.deliver
    render json: "true"
  end

  def add_new_merchant
      @merchant = current_user
      @merchants = Merchant.new
  end

  def save_new_merchant
    merchant = params[:merchants]
    judge_input = judge_add_input(merchant)
    @merchants = Merchant.new(:user_name=>merchant[:user_name],:restaurant_name=>merchant[:restaurant_name],:addr=>"",:phone=>"",
                              :remark=>"",:status=>"checked",:password=>merchant[:password],
                              :password_confirmation=>merchant[:password_confirmation],
                              :private_cuisine=>merchant[:private_cuisine],:outer_sell=>merchant[:outer_sell])
    @merchants.save
    if judge_input == 'legal' && @merchants.save
      redirect_to :admin_index
    end
  end

  def save_modify_merchant_id
      session[:modify_merchant_id] = Merchant.find_by(user_name: params[:user_name]).id
      redirect_to :modify_merchant_info
  end

  def modify_merchant_info
      @merchant = current_user
      @modify_merchant = Merchant.find_by(id: session[:modify_merchant_id])
  end

  def save_new_label
    category_array = params['label']['category'].split(',')
    current_url = category_array[2][8..-3]
    judge_input = judge_add_label_input(params,current_url)
    if judge_input == 'legal'
      if current_url == "label_site_list"
        if params[:label][:postcode].present?
          @label = Label.create(:content=>params[:label][:content] + "-"+params[:label][:postcode],:site=>params[:label][:content],:postcode=>params[:label][:postcode],:create_type=>"admin",:category=>category_array[1][10..12],:category_id=>category_array[0][6..-1])
        else
          @label = Label.create(:content=>params[:label][:content],:site=>params[:label][:content],:create_type=>"admin",:category=>category_array[1][10..12],:category_id=>category_array[0][6..-1])
        end
      else
        @label = Label.create(:content=>params[:label][:content],:create_type=>"admin",:category=>category_array[1][10..12],:category_id=>category_array[0][6..-1])
      end

        redirect_to "/admin/" + current_url
    end
  end

  def update_merchant_info
    judge_input = judge_modify_input(params[:modify_merchant])
    if judge_input == 'legal'
      @modify_merchant = Merchant.find_by(id: session[:modify_merchant_id])
      @modify_merchant.restaurant_name=params[:modify_merchant][:restaurant_name]
      @modify_merchant.password = params[:modify_merchant][:password]
      @modify_merchant.password_confirmation = params[:modify_merchant][:password_confirmation]
      @modify_merchant.private_cuisine=params[:modify_merchant][:private_cuisine]
      @modify_merchant.outer_sell=params[:modify_merchant][:outer_sell]
      @modify_merchant.save
      @merchant = current_user
      session[:success] = 'true'
      render :modify_merchant_info
    end
  end

  def judge_modify_input(merchant)
    @modify_merchant = Merchant.find_by(id: session[:modify_merchant_id])
    if merchant[:restaurant_name] == '' || merchant[:password] == '' || merchant[:password_confirmation]==''
      flash.now[:error] = '输入不能为空'
      @merchant = current_user
      return render :modify_merchant_info
    end
    if merchant[:password] != merchant[:password_confirmation]
      flash.now[:error] = '两次密码输入不一致'
      @merchant = current_user
      return render :modify_merchant_info
    end
    'legal'
  end

  def judge_add_input(merchant)
    if merchant[:user_name]==''|| merchant[:restaurant_name] == '' || merchant[:password] == '' || merchant[:password_confirmation]==''
      flash.now[:error] = '输入不能为空'
      @merchant = current_user
      return render :add_new_merchant
    end
    if merchant[:password] != merchant[:password_confirmation]
      flash.now[:error] = '两次密码输入不一致'
      @merchant = current_user
      return render :add_new_merchant
    end
    is_repeat = !Merchant.find_by(user_name:merchant[:user_name]).nil?
    if is_repeat
      flash.now[:error] = '用户名已注册'
      @merchant = current_user
      return render :add_new_merchant
    end
    'legal'
  end

  def judge_add_label_input(params,current_url)
    if current_url == "label_site_list"
      @label_list = paginate(Label.order('category_id').where(:category_id=>1),50)
    end
    if current_url == "label_dish_style_list"
      @label_list = paginate(Label.order('category_id').where(:category_id=>2),50)
    end
    if current_url == "label_flavour_list"
      @label_list = paginate(Label.order('category_id').where(:category_id=>3),50)
    end
    @label = Label.new
    @merchant = current_user
    if params[:label][:content]=='' || !params[:label][:category]
      flash.now[:error] = '*请将内容填写完整'
      return render current_url
    end
    labels=Label.all
    labels.each do |label|
      if current_url == "label_site_list"
        if label[:content].gsub(" ","").split('-')[0]==params[:label][:content].gsub(" ","")
          flash.now[:repeat_error] = '*标签内容已存在，请重新填写'
          return render current_url
        end
      else
        if label[:content].gsub(" ","")==params[:label][:content].gsub(" ","")
          flash.now[:repeat_error] = '*标签内容已存在，请重新填写'
          return render current_url
        end
      end
    end
    'legal'
  end

  def delete_merchant
    user_id = Merchant.find_by(user_name:params[:user_name]).id
    Merchant.find_by(id: user_id).delete
    MerchantLabel.where(:user_id=>user_id).delete_all
    Dish.where(:user_id=>user_id).delete_all
    redirect_to :admin_index
  end

  def delete_label
    Label.find_by(id:params[:delete_label_id]).delete
    DishLabel.where(:label_id=>params[:delete_label_id]).delete_all
    MerchantLabel.where(:label_id=>params[:delete_label_id]).delete_all
    ajax_response
  end

  def roll_images_manager
      @merchant = current_user
      @roll_image = RollImage.new
      @show_roll_image = RollImage.first
  end

  def set_home_ad
    @home_ad=HomeAd.new
    @merchant = current_user
  end

  def set_bg_logo
    @merchant = current_user
  end

  def set_about_us
    @merchant = current_user
    text=Text.find_by(title:'about_us')
    if text
      @about_us_text=text[:content]
    else
      @about_us_text='请输入内容...'
    end
  end

  def save_about_us
    text=Text.find_by(title:'about_us')
    if text
      text[:content]=params[:about_us]
      text.save
    else
      Text.create(:title=>'about_us',:content=>params[:about_us])
    end
    render json: "true"
  end

  def set_terms_conditions
    @merchant = current_user
    text=Text.find_by(title:'terms_conditions')
    if text
      @terms_conditions_text=text[:content]
    else
      @terms_conditions_text='请输入内容...'
    end
  end

  def save_terms_conditions
    text=Text.find_by(title:'terms_conditions')
    if text
      text[:content]=params[:terms_conditions]
      text.save
    else
      Text.create(:title=>'terms_conditions',:content=>params[:terms_conditions])
    end
    render json: "true"
  end

  def set_privacy_security
    @merchant = current_user
    text=Text.find_by(title:'privacy_security')
    if text
      @privacy_security_text=text[:content]
    else
      @privacy_security_text='请输入内容...'
    end
  end

  def save_privacy_security
    text=Text.find_by(title:'privacy_security')
    if text
      text[:content]=params[:privacy_security]
      text.save
    else
      Text.create(:title=>'privacy_security',:content=>params[:privacy_security])
    end
    render json: "true"
  end

  def label_dish_style_list
      @current_url = "label_dish_style_list"
      @merchant = current_user
      @label = Label.new
      @label_list = paginate(Label.get_labels_by_category_id(2),50)
  end

  def label_site_list
      @current_url = "label_site_list"
      @merchant = current_user
      @label = Label.new
      @label_list = paginate(Label.get_labels_by_category_id(1),50)
  end

  def label_flavour_list
      @current_url = "label_flavour_list"
      @merchant = current_user
      @label = Label.new
      @label_list = paginate(Label.get_labels_by_category_id(3),50)
  end

  def process_roll_images
    p '-----------------------------'
    is_exist = RollImage.find(:all).length
    p '---------------------'
    p is_exist
    if is_exist==0
      p '-------------------------'
      save_roll_images(params)
    end
    if is_exist!=0
      update_roll_images(params)
    end
  end

  def process_site_photo
    if SitePhoto.all.length !=0
      update_site_photos(params)
    else
      save_site_photos(params)
    end
  end

  def  save_site_photos(params)
    site_photo=SitePhoto.new(params[:site_photo])
    if site_photo.save
      session[:success]='true'
      redirect_to :set_bg_logo
      return
    end
  end

  def update_site_photos(params)
    site_photo=SitePhoto.first
    site_photo.update_attributes(params[:site_photo])
    session[:success]='true'
    redirect_to :set_bg_logo
  end

  def process_home_ad
    if HomeAd.all.length !=0
      update_home_ads(params)
    else
      save_home_ads(params)
    end
  end

  def save_home_ads(params)
    home_ad=HomeAd.new(params[:home_ad])
    if home_ad.save
      session[:success]='true'
      redirect_to :set_home_ad
    end
  end

  def update_home_ads(params)
    home_ad=HomeAd.first
    home_ad.update_attributes(params[:home_ad])
    session[:success]='true'
    redirect_to :set_home_ad
  end

  def save_roll_images(params)
    roll_image = RollImage.new(params[:roll_image])
    roll_image.save
    if roll_image.save
      session[:success]='true'
      redirect_to :roll_images_manager
    end
  end

  def update_roll_images(params)
    update_roll_image = RollImage.first
    update_roll_image.update_attributes(params[:roll_image])
    if update_roll_image
      session[:success]='true'
      redirect_to :roll_images_manager
    end
  end

  def delete_roll_image
    roll_order = params[:delete_roll_order]
    roll_image = RollImage.first
    if roll_order == "1"
      roll_image.photo_1 = nil
    end
    if roll_order == "2"
      roll_image.photo_2 = nil
    end
    if roll_order == "3"
      roll_image.photo_3 = nil
    end
    if roll_order == "4"
      roll_image.photo_4 = nil
    end
    if roll_order == "5"
      roll_image.photo_5 = nil
    end
    roll_image.save
    ajax_response
  end

end
