class OrdersController < ApplicationController
  def new
    @user = current_user
    @product = Event.find(params[:event_id].to_i)
    @amount = @product.price
    @stripe_amount = (@amount * 100).to_i
  end

  def create
    # Before the rescue, at the beginning of the method
    @user = current_user
    @product = Event.find(3)
    @amount = @product.price
    @stripe_amount = (@amount * 100).to_i
    begin
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })
      @stripe_id = customer.id
      charge = Stripe::Charge.create({
        customer: @stripe_id,
        amount: @stripe_amount,
        description: "Achat d'un produit",
        currency: 'eur',
      })
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_order_path
      end
    # After the rescue, if the payment succeeded
    try = Attendance.create(participant_id: current_user.id, event_id: params[:event_id].to_i, reserved: true, stripe_id: @stripe_id)
    redirect_to event_path(params[:event_id])
  end
end
