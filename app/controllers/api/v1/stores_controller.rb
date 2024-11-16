# app/controllers/api/v1/stores_controller.rb
module Api
    module V1
      class StoresController < ApplicationController
        # 店舗の現在の利用者数を取得するエンドポイント
        def current_occupancy
          store = Store.find(params[:id])
  
          # 利用者数を計算
          current_occupancy_count = store.transactions
                                          .where(action: 'entry')
                                          .count
  
          render json: { store_id: store.id, current_occupancy: current_occupancy_count }, status: :ok
        rescue ActiveRecord::RecordNotFound
          render json: { error: 'Store not found' }, status: :not_found
        end
      end
    end
  end
  
