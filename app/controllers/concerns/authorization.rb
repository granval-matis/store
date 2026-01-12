module Authorization
  extend ActiveSupport::Concern

  class_methods do
    def admin_access_only(**options)
      before_action -> { redirect_to root_path, alert: "You aren't allowed to do that." unless authenticated? && Current.user.admin? }, **options
    end

    def seller_access_only(**options)
      before_action -> { redirect_to root_path, alert: "You aren't allowed to do that." unless authenticated? && (Current.user.seller? || Current.user.admin?) }, **options
    end

    def buyer_access_only(**options)
      before_action -> { redirect_to root_path, alert: "You aren't allowed to do that." unless authenticated? && (Current.user.buyer? || Current.user.admin?) }, **options
    end
  end
end
