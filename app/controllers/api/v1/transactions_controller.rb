# app/controllers/api/v1/transactions_controller.rb
module Api
    module V1
      class TransactionsController < ApplicationController
        before_action :set_store
        before_action :find_or_create_customer
  
        # POST /api/v1/transactions/entry
        def entry
          transaction = @store.transactions.create(
            customer_id: @customer.id,
            action: 'entry',
            action_timestamp: Time.zone.now,
            day_of_week: Time.zone.now.wday,
            time_of_day: determine_time_of_day(Time.zone.now)
          )
  
          if transaction.persisted?
            render json: { message: 'Entry recorded', transaction: transaction }, status: :created
          else
            render json: { error: 'Entry failed', details: transaction.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        # POST /api/v1/transactions/exit
        def exit
          transaction = @store.transactions.find_by(customer_id: @customer.id, action: 'entry')
  
          if transaction
            transaction.update(action: 'exit', action_timestamp: Time.zone.now)
            render json: { message: 'Exit recorded', transaction: transaction }, status: :ok
          else
            render json: { error: 'No entry record found for this customer' }, status: :not_found
          end
        end
  
        private
  
        # 店舗情報を取得
        def set_store
          @store = Store.find_by(id: params[:store_id])
          return render json: { error: 'Store not found' }, status: :not_found if @store.nil?
        end
  
        # 顧客をUUIDを使って検索し、新規の場合は作成
        def find_or_create_customer
          # CookieにUUIDがなければ新規生成して設定
          if cookies[:customer_uuid].blank?
            cookies[:customer_uuid] = { value: SecureRandom.uuid, expires: 1.year.from_now }
          end
  
          # UUIDから顧客を検索または新規作成
          @customer = Customer.find_or_create_by(uuid: cookies[:customer_uuid], entry_time: Time.zone.now)
        end

        def determine_time_of_day(current_time)
          hour = current_time.hour
          case hour
          when 5..11 then 'morning'
          when 12..17 then 'afternoon'
          when 18..21 then 'evening'
          else 'night'
          end
        end
      end
    end
  end
  