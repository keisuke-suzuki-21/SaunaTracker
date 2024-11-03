# app/controllers/api/v1/transactions_controller.rb
module Api
    module V1
      class TransactionsController < ApplicationController
        # POST /api/v1/transactions/entry
        def entry
          store = Store.find_by(id: params[:store_id])
  
          # 店舗が存在しない場合のエラーハンドリング
          return render json: { error: 'Store not found' }, status: :not_found if store.nil?
  
          # 新規トランザクション（入場）を作成
          transaction = store.transactions.create(
            customer_id: params[:customer_id],
            action: 'entry',
            action_timestamp: Time.zone.now
          )
  
          if transaction.persisted?
            render json: { message: 'Entry recorded', transaction: transaction }, status: :created
          else
            render json: { error: 'Entry failed', details: transaction.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        # POST /api/v1/transactions/exit
        def exit
          store = Store.find_by(id: params[:store_id])
          return render json: { error: 'Store not found' }, status: :not_found if store.nil?
  
          # 顧客の最後の入場トランザクションを取得して退場を記録
          transaction = store.transactions.find_by(customer_id: params[:customer_id], action: 'entry')
  
          if transaction
            # トランザクションに退場アクションを追加
            transaction.update(action: 'exit', action_timestamp: Time.zone.now)
  
            render json: { message: 'Exit recorded', transaction: transaction }, status: :ok
          else
            render json: { error: 'No entry record found for this customer' }, status: :not_found
          end
        end
  
        # GET /api/v1/transactions/count
        def count
          store = Store.find_by(id: params[:store_id])
          return render json: { error: 'Store not found' }, status: :not_found if store.nil?
  
          # 入場中の顧客数を取得
          count = store.transactions.where(action: 'entry').count
  
          render json: { store_id: store.id, current_customers: count }, status: :ok
        end
      end
    end
  end
  