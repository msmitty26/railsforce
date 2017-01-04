class SentMessagesController < EndUserBaseController
  before_action :authenticate_user!

  def index
    @sent_messages = current_user.sent_messages.all
  end
end