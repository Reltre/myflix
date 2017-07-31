require 'shoulda-matchers'

module ShouldaMatcherFixes
  # https://github.com/thoughtbot/shoulda-matchers/blob/master/lib/shoulda/matchers/action_controller/permit_matcher.rb
  module PermitMatcher
    # Monkey patch for Rails 5
    #
    # Original: https://github.com/thoughtbot/shoulda-matchers/blob/44c0198830921650af3b4a56f5d72aaae2168480/lib/shoulda/matchers/action_controller/permit_matcher.rb#L246-L257
    # Fix taken from: https://github.com/thoughtbot/shoulda-matchers/issues/1018#issuecomment-303796064
    #
    # @todo Put some type of check here so that the fix does not come out
    #   and we are stuck with this still kicking around.
    def matches?(controller)
      @controller = controller
      ensure_action_and_verb_present!

      parameters_double_registry.register

      Shoulda::Matchers::Doublespeak.with_doubles_activated do
        # context.__send__(verb, action, request_params)
        context.__send__(verb, action, params: request_params)
      end

      unpermitted_parameter_names.empty?
    end
  end
end

Shoulda::Matchers::ActionController::PermitMatcher.prepend ShouldaMatcherFixes::PermitMatcher
