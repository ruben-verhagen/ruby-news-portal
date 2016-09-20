require 'action_dispatch/routing/route_set'

module ActionDispatch
  module Routing
    class UrlFor #:nodoc:
      def url_for_with_subdomains(options, path_segments=nil)
        binding.pry

      end

      alias_method_chain :url_for, :subdomains
    end
  end
end