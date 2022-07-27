require 'securerandom'
require 'date'

module Utilities
  class Util < ApplicationController
    def get_random_uuid
      SecureRandom.uuid
    end

    def gen_assigned_code(sequence)
      sql = "select nextval('#{sequence}')"
      val = ActiveRecord::Base.connection.execute(sql)
      val = val.values[0][0]
      val = val.to_s.rjust(4,'0')

      date = Time.new
      
      formatted_value = "#{date.year}#{date.month}#{date.day}".concat(val)

      formatted_value
    end

    def calculate_amount(amount)

      percentage_amount = amount.to_f * RATES
      total_amount = 0.0
      case 
      when percentage_amount < CAPPED_AMOUNT
        total_amount = amount.to_f + percentage_amount
      else
        total_amount = amount.to_f + CAPPED_AMOUNT
      end
      
      total_amount 
    end

    def send_success_response(payload)
      {resp_code: SUCCESS, payload: payload, status: SUCCESS}
    end

    def send_failed_response(error)
      {resp_code: ERROR, data: error, status: ERROR}
    end
  end
end