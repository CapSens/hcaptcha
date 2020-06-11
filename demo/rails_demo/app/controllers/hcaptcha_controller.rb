class HcaptchaController < ApplicationController
  def hcaptcha; end

  def invisible_hcaptcha; end

  def verify_demo
    captcha_response = verify_hcaptcha
    if captcha_response[0]
      flash[:success] = "Congratulations #{params[:name]} !! You are not a robot"
    else
      flash[:error] = 'I know that you are the one you pretend to be ...'
    end

    redirect_to(root_path)
  end
end
