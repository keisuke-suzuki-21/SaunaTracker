namespace :qr_code do
    desc "Generate QR codes for a specific store"
    task generate_for_store: :environment do
      store_id = ENV['STORE_ID']
  
      if store_id.nil?
        puts "Please specify the STORE_ID (e.g., STORE_ID=1)"
        exit
      end
  
      store = Store.find_by(id: store_id)
      
      if store
        QrCodeGenerator.generate_for_store(store.id)
        puts "Generated QR codes for store #{store.id}"
      else
        puts "Store with ID #{store_id} not found"
      end
    end
end