# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

# pin "chart.js" # @4.4.7
pin 'chart.js', to: 'https://ga.jspm.io/npm:chart.js@4.4.6/dist/chart.js' # @4.4.6
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.4

pin_all_from "app/javascript/controllers", under: "controllers"