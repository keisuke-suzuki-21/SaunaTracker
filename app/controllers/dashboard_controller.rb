class DashboardController < ApplicationController
  def index
    # リアルタイム利用者数の取得
    @current_users = current_store.current_occupancy
    @customer_data = {
      age_groups: { '20代': 30, '30代': 50, '40代以上': 20 },
      visit_frequency: { '週1回': 40, '週2回以上': 60 }
    }
    @messages_status = { sent: 100, clicked: 60 }
    @events = ['キャンペーン開始', '来月のイベント発表']
  end
end
