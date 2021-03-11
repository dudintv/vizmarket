class FeedbackMessageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :message, :contacts, :created_at
end
