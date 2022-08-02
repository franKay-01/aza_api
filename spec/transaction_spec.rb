require 'rails_helper'
# require 'auth_helper'

RSpec.describe 'AllTests', type: :request do
  describe 'Auth and Transaction Testing' do
  
    it 'returns & checks auth' do
      post '/auth', params: {"user":{"email":"kay1@gmail.com","password":"test12345"}}

      auth_record = JSON.parse(response.body)
      @email = auth_record['data']['username']['email']
      @token = auth_record['data']['token']
      @resp_code = auth_record['resp_code']

      expect(@email).to match("kay1@gmail.com")
      expect(@token).to  be_kind_of(String)
      expect(@resp_code).to  match(200)
    end


    it 'creates new transaction and check' do
      post '/auth', params: {"user":{"email":"kay1@gmail.com","password":"test12345"}}
      auth_record = JSON.parse(response.body)
      @token = auth_record['data']['token']
      
      post '/transactions', params: {"transaction":{"amount": 1000,"amount_currency": "GH"}}, headers: {"Authorization" => " #{@token}"}
      transaction_record = JSON.parse(response.body)

      @resp_code = transaction_record['resp_code']
      @amount_currency = transaction_record['payload']['amount_currency']
      @expected_amount = transaction_record['payload']['output_amount']

      expect(@amount_currency).to match("GH")
      expect(@expected_amount).to match("1015.0")
      expect(@resp_code).to  match(200)
    end

    it 'update transaction' do
      post '/auth', params: {"user":{"email":"kay1@gmail.com","password":"test12345"}}
      auth_record = JSON.parse(response.body)
      @token = auth_record['data']['token']

      post "/update_transaction/#{2022820047}", params: {"transaction":{"amount": 5444000,"amount_currency": "EUR"}}, headers: {"Authorization" => " #{@token}"}
      transaction_record = JSON.parse(response.body)
      @resp_code = transaction_record['resp_code']
      @amount_currency = transaction_record['payload']['amount_currency']
      @expected_amount = transaction_record['payload']['output_amount']

      expect(@amount_currency).to match("GH")
      expect(@expected_amount).to match("5444300.0")
      expect(@resp_code).to  match(200)
    end
  end
end
