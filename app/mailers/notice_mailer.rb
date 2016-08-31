class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_blog.subject
  #
  def sendmail_blog(blog)
    @blog = blog
    
    mail to:"dragonko15296@gmail.com",
         subject: '【Achieve】記事が投稿されました'
  end
end