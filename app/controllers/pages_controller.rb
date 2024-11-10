class PagesController < ApplicationController
    def entry
        @store_id = params[:store_id]
        @action = params[:action]
        render :entry #HTMLビューをレンダリング
    end

    def exit
        @store_id = params[:store_id]
        @action = params[:action]
        render :entry #HTMLビューをレンダリング
    end
end