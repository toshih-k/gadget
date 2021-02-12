# frozen_string_literal: true

require 'test_helper'

module Gadget
  class Test < ActiveSupport::TestCase
    test 'truth' do
      assert_kind_of Module, Gadget
    end
  end
end
