class UserMailer < ApplicationMailer
  default from: 'hoge@gmail.com'

  def giving_award_email(giver_id, given_id)
    @giver_user = User.find_by(id: giver_id)
    @given_user = User.find_by(id: given_id)
    mail to: @given_user.email,
         subject: "#{@given_user.email}から賞を受けとりました"
  end
end
