# frozen_string_literal: true

# Copyright 2016-2017 New Context Services, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "support/kitchen/terraform/define_config_attribute_context"

::RSpec.shared_examples "config attribute :color" do
  include_context "Kitchen::Terraform::DefineConfigAttribute", attribute: :color do
    context "when the config omits :color" do
      context "when the Test Kitchen process is not associated with a terminal device" do
        before do
          allow(::Kitchen).to receive(:tty?).with(no_args).and_return false
        end

        it_behaves_like "a default value is used", default_value: false
      end

      context "when the Test Kitchen process is associated with a terminal device" do
        before do
          allow(::Kitchen).to receive(:tty?).with(no_args).and_return true
        end

        it_behaves_like "a default value is used", default_value: true
      end
    end

    context "when the config associates :color with a nonboolean" do
      it_behaves_like "the value is invalid",
                      error_message: /color.*must be boolean/,
                      value: "abc"
    end

    context "when the config associates :color with a boolean" do
      it_behaves_like "the value is valid",
                      value: false
    end
  end
end
