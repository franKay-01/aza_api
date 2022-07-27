require "test_helper"

class TranscationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transcation = transcations(:one)
  end

  test "should get index" do
    get transcations_url, as: :json
    assert_response :success
  end

  test "should create transcation" do
    assert_difference("Transaction.count") do
      post transcations_url, params: { transcation: { amount: @transcation.amount, created_at: @transcation.created_at, currency: @transcation.currency, customer_id: @transcation.customer_id, updated_at: @transcation.updated_at, uuid: @transcation.uuid } }, as: :json
    end

    assert_response :created
  end

  test "should show transcation" do
    get transcation_url(@transcation), as: :json
    assert_response :success
  end

  test "should update transcation" do
    patch transcation_url(@transcation), params: { transcation: { amount: @transcation.amount, created_at: @transcation.created_at, currency: @transcation.currency, customer_id: @transcation.customer_id, updated_at: @transcation.updated_at, uuid: @transcation.uuid } }, as: :json
    assert_response :success
  end

  test "should destroy transcation" do
    assert_difference("Transaction.count", -1) do
      delete transcation_url(@transcation), as: :json
    end

    assert_response :no_content
  end
end
