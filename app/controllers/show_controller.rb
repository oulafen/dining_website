# coding: utf-8
class ShowController < ApplicationController
  before_action :show_visitor,:show_logo
  require 'mail'

  options = {:address => "smtp.gmail.com",
             :port => 587,
             :domain => 'localhost',
             :user_name => 'eatparadiseaus@gmail.com',
             :password => 'aassddwwss11',
             :authentication => 'plain',
             :enable_starttls_auto => true}

  Mail.defaults do
    delivery_method :smtp, options
  end

  def show_logo
    @site_photo=SitePhoto.first
    if SitePhoto.first
      @bg=@site_photo.photo_1.url
    end
  end

  def show_visitor
    if cookies.permanent[:visitors_id]
      flash.now[:visitors]="true"
      @visitors=User.find(cookies.permanent[:visitors_id])
    end
  end
  def home
    if params[:name]&& params[:active_num]
      user=User.find_by(name: params[:name],active_num:params[:active_num])
      if user
        user[:status]="checked"
        user.save
        cookies.permanent[:visitors_id] = user[:id]
      end
    end
    if cookies.permanent[:visitors_id]
      flash.now[:visitors]="true"
      @visitors=User.find(cookies.permanent[:visitors_id])
    end
    @labels_restaurants = Label.get_all_site_labels
    @roll_images = RollImage.get_roll_image
    @home_ad=HomeAd.first
  end

  def recover_password
    user=User.find_by(email:params[:email])
    if user
      name=user[:name]
      active_num=user[:active_num]
      mail_to = user[:email]
      mail = Mail.new
      mail.charset = 'UTF-8'
      mail.content_transfer_encoding = '8bit'
      mail.from = 'dining_website'
      mail.to = "#{mail_to}"
      mail.subject = "找回密码通知"
      mail.text_part do
        body "找回密码通知"
      end
      mail.html_part do
        content_type 'text/html; charset=UTF-8'
        body "<h2>Hi,亲爱的#{name}</h2>
              <p>
               点击以下链接修改吃货天堂密码：<br>
               <a href=http://www.eatparadise.com/modify_password?name=#{name}&active_num=#{active_num}>http://www.eatparadise.com/modify_password?name=#{name}&active_num=#{active_num}</a><br>
               如果链接不能正常显示，请手动复制链接到地址栏访问<br>
               如果您没有注册此账号，请忽略此邮件"
      end
      mail.deliver


      respond_to do |format|
        format.json {render json: {:status=>'found'}}
      end
    else
      respond_to do |format|
        format.json {render json: {:status=>'not_found'}}
      end
    end
  end

  def modify_password
    if params[:name] && params[:active_num]
      user=User.find_by(name:params[:name],active_num:params[:active_num])
      if user
        @name=user[:name]
      end
    end
  end

  def process_new_password
    user=User.find_by(name:params[:user][:name][7...-5])
    user.password=params[:user][:password]
    user.password_confirmation=params[:user][:password_confirmation]
    user.save
    cookies.permanent[:visitors_id] = user[:id]
    render json: "true"
  end

  def user_login
    user=User.find_by(name:params[:name],status:"checked")
    if user && user.authenticate(params[:password])
      if session[:user_id]
        session.delete(:user_id)
      end
      cookies.permanent[:visitors_id]=user[:id]
      respond_to do |format|
        format.json{render json: {:data=>"true"}}
      end
    else
      respond_to do |format|
        format.json{render json: {:data=>"not_found"}}
      end
    end
  end

  def user_logout
    cookies.delete(:visitors_id)
    redirect_to :back
  end

  def create_new_user
    if User.find_by(name: params[:user][:name])
      respond_to do |format|
        format.json {render json: {:data => "name_repeated"}}
      end
    elsif User.find_by(email: params[:user][:email])
      respond_to do |format|
        format.json {render json: {:data => "email_repeated"}}
      end
    else
      user=User.new(params[:user])
      user[:active_num]= rand(999999)
      user.save
      name=user[:name]
      active_num=user[:active_num]
      mail_to = params[:user][:email]
      mail = Mail.new
      mail.charset = 'UTF-8'
      mail.content_transfer_encoding = '8bit'
      mail.from = 'dining_website'
      mail.to = "#{mail_to}"
      mail.subject = "账号注册通知"
      mail.text_part do
        body "账号注册通知"
      end
      mail.html_part do
        content_type 'text/html; charset=UTF-8'
        body "<h2>Hi,亲爱的#{name}</h2>
              <p>
               感谢您注册吃货天堂。请点击链接激活账号：<br>
               <a href=http://www.eatparadise.com/home?name=#{name}&active_num=#{active_num}>http://www.eatparadise.com/home?name=#{name}&active_num=#{active_num}</a><br>
               如果链接不能正常显示，请手动复制链接到地址栏访问<br>
               如果您没有注册此账号，请忽略此邮件"
      end
      mail.deliver

      respond_to do |format|
        format.json {render json: {:data => "true"}}
      end
    end
  end

  def new_comment
      comment=  Comment.new(params[:comment]);
      if comment.save;
      respond_to do |format|
        format.json {render json: {:data => "true"}}
      end
      else
        respond_to do |format|
          format.json {render json: {:data => "false"}}
        end
      end

  end

  def home_label_detail
    @label_content = session[:label_content]
    @merchant_detail = Merchant.get_merchant_detail(@label_content)
    @merchants = Merchant.get_merchants(@label_content)
    @infos=Label.get_site_infos(@merchant_detail)
  end

  def save_header_label_content_to_session
    session[:label_content] = params[:label_content]
    ajax_response
  end

  def save_label_content_to_session
    session[:home_site_label_content] = params[:label_content]
    ajax_response
  end

  def site_label_detail
    @label_content = session[:home_site_label_content]
    @merchant_detail = Merchant.get_merchant_detail(@label_content)
    @merchants = Merchant.get_merchants(@label_content)
  end

  def restaurant_detail
    @label_content = params[:label_content]
    if params[:label_content]
      @category=Label.find_by("content like ?", "%#{@label_content}%")[:category_id]
    end
    merchants = Merchant.find_by(id:params[:merchant_id])
    if !merchants.nil?
      merchants['remark']=merchants['remark'].gsub(/\r\n/,'<br/>')
    end
    @merchant=merchants
    if @merchant.nil?
      return redirect_to :not_find_merchant_show
    end
    @dishes_by_group = Dish.get_dishes_by_group(@merchant.id)
    @dishes_names_by_group = Dish.get_dish_names(@merchant.id)
    @favor_num=Favor.where(merchant_id: @merchant[:id]).length
    if @visitors
      favors=Favor.where(user_id:@visitors[:id]).map{|favor|favor[:merchant_id]}
      @merchant_favors={"merchant_id"=>@merchant[:id],"user_favors"=>favors}
    end
    @other_addrs=Addr.where(:user_id => params[:merchant_id])

    comments=Comment.get_comment(@merchant.restaurant_name)
    @comments=comments.map do  |comment|
      comment['merchant_name']=comment['merchant_name']
      comment['user_name']=comment['user_name']
      comment['created_at']=comment['created_at']
      comment['comment']=comment['comment'].gsub(/\n/,'<br/>')
      comment
    end
  end

  def delete_favor
    favor=Favor.find_by(user_id:params[:user_id],merchant_id:params[:merchant_id])
    favor.destroy
    redirect_to :action => "restaurant_detail",:merchant_id=>params[:merchant_id]
  end

  def add_favor
    favor=Favor.find_by(:user_id=>params[:user_id],:merchant_id=>params[:merchant_id])
    if !favor
      Favor.create(:user_id=>params[:user_id],:merchant_id=>params[:merchant_id])
      redirect_to :action => "restaurant_detail",:merchant_id=>params[:merchant_id]
    end
  end

  def not_find_merchant_show

  end

  def send_mail
    mail_to = params[:mail]["mail_to"]
    body = params[:mail]["mailer_content"]
    name = params[:mail]['mailer_name']
    phone = params[:mail]["mailer_phone"]
    email = params[:mail]["mailer_email"]
    restaurant_name = params[:mail]["mailer_restaurant_name"]

    mail = Mail.new
    mail.charset = 'UTF-8'
    mail.content_transfer_encoding = '8bit'
    mail.from = 'dining_website'
    mail.to = "#{mail_to}"
    mail.subject = "有新伙伴想要加入哦"
    mail.text_part do
      body "管理员你好，客户 #{name} 想加入我们，他的餐馆名称是 #{restaurant_name},他的电话是 #{phone} ,他的邮箱是 #{email} ,他的邮件内容是 '#{body}'"
    end
    mail.html_part do
      content_type 'text/html; charset=UTF-8'
      body "<h1>Dear admin</h1>
            <p>
              You have successfully accepted a new partner's email from DiningWebsite,<br>
              His/Her name is: #{name}.<br>
              His/Her restaurant_name is: #{restaurant_name}.<br>
              His/Her mobile number is: #{phone}.<br>
              His/Her E-mail address is: #{email}.<br>
              He/She said :#{body}
            </p>
            <h2>Have a great day!</h2>"
    end
    mail.deliver
    ajax_response
  end

  def register_merchant
    @merchant=Merchant.new
  end

  def process_register_merchant
    Merchant.create(:user_name=>params[:merchant][:user_name],:restaurant_name=>params[:merchant][:restaurant_name],:password=>params[:merchant][:password],:password_confirmation=>params[:merchant][:password_confirmation],:phone=>params[:merchant][:phone],:status=>"checking",:email=>params[:merchant][:email])
    render json: "true"
  end

  def footer_about
    text=Text.find_by(title:'about_us')
    if text
      @about=text[:content]
    else
      @about='暂无介绍'
    end
  end

  def footer_terms_conditions
    text=Text.find_by(title:'terms_conditions')
    if text
      @terms_conditions=text[:content]
    else
      @terms_conditions='暂无介绍'
    end
  end

  def footer_privacy_security
    text=Text.find_by(title:'privacy_security')
    if text
      @privacy_security=text[:content]
    else
      @privacy_security='暂无介绍'
    end
  end

  def all_site_labels
    @labels_restaurants = Label.get_all_site_labels
  end

end