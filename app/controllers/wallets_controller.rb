# app/controllers/wallets_controller.rb
class WalletsController < ApplicationController
    before_action :authenticate_user
    before_action :set_entity
  
    def balance
        if @wallet
            render json: { balance: @wallet.balance }
          else
            render json: { error: 'Wallet not found for the specified entity' }, status: :not_found
        end
    end
  
    def debit
        amount = params[:amount].to_f
        if amount <= 0
          render json: { error: 'Invalid amount for debit' }, status: :unprocessable_entity
        elsif @wallet.balance < amount
          render json: { error: 'Insufficient funds for debit' }, status: :unprocessable_entity
        else
          # Assuming your Debit model has an attribute named 'amount'
          debit = Debit.create!(wallet: @entity.wallet, amount: amount)
      
          # Update the wallet balance after a debit transaction
          @entity.wallet.update_balance_after_debit(amount)
      
          render json: { message: 'Debit transaction successful' }
        end
      end
    
      def credit
        amount = params[:amount].to_f
        if amount <= 0
          render json: { error: 'Invalid amount for credit' }, status: :unprocessable_entity
        else
          # Assuming your Credit model has an attribute named 'amount'
          credit = Credit.create!(wallet: @entity.wallet, amount: amount)
    
          # Update the wallet balance after a credit transaction
          @entity.wallet.update_balance_after_credit(amount)
    
          render json: { message: 'Credit transaction successful' }
        end
      end

    def create
        @wallet = Wallet.create(entity: @entity)
    
        if @wallet.persisted?
          render json: { message: 'Wallet created successfully' }
        else
          render json: { error: 'Failed to create wallet' }, status: :unprocessable_entity
        end
    end
    
  
    private
  
    def authenticate_user
        token = request.headers['Authorization']&.split&.last
        session = Session.find_by(token: token)
      
        if session
          @current_user = session.user
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end
      
  
    def set_entity
        # Implement logic to find the entity based on the request (User, Team, Stock, etc.)
        #entity_id = params[:entity_id]
        entity_id = params[:entity_id]
        entity_type = params[:entity_type]
      
        puts "Entity ID: #{entity_id}, Entity Type: #{entity_type}"
      
        begin
          @entity = entity_type.constantize.find(entity_id)
          @wallet = @entity.wallet
        rescue ActiveRecord::RecordNotFound
          render json: { error: 'Entity not found' }, status: :not_found
        end
    end
  end
  