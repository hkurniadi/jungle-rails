class UserMailer < ApplicationMailer
  def confirmation_email(order)
    @order = order
    mail(to: @order.email, subject: "Order ID - #{@order.id}")
  end
end
