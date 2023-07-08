ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  include Devise::Test::IntegrationHelpers

  def assert_error_message_translated(record_type, model, attribute, error_key, params = {})
    class_name = params[:class_name] || model.class.name
    expected_error_message = I18n.t("#{record_type}.errors.models.#{class_name.underscore}.attributes.#{attribute}.#{error_key}", **params)
    refute expected_error_message.include?('translation missing:'), "No translation found for #{attribute}.#{error_key}"
    assert model.errors[attribute].any? { |message| expected_error_message == message }, "Model has not expected error message \"#{expected_error_message}\""
  end
end
