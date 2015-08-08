require 'test_helper'

class ApiKeyTest < ActiveSupport::TestCase
   test "sets token before create" do
     assert ApiKey.create(user_id: 1).token != nil
   end

   test "sets expires_at before create" do
     assert ApiKey.create(user_id: 1).expires_at != nil
   end

   test "belongs to a user" do
     assert_respond_to ApiKey.new, :user
   end

   test "has a fresh scope" do
     assert_respond_to ApiKey, :fresh
   end
end
