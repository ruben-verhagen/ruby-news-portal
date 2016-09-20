require 'devise/strategies/base'

module Devise
  module Strategies
    class CasAuthenticatable < Base

      def authenticate!
        ticket = read_ticket(params)
        if ticket
          if resource = mapping.to.authenticate_with_cas_ticket(ticket)
            # Store the ticket in the session for later usage
            if ::Devise.cas_enable_single_sign_out
              session['cas_last_valid_ticket'] = ticket.ticket
              session['cas_last_valid_ticket_store'] = true
            end

            resource.request_role

            success!(resource)
          elsif ticket.is_valid?
            username = ticket.respond_to?(:user) ? ticket.user : ticket.response.user
            redirect!(::Devise.cas_unregistered_url(request.url, mapping), :username => username)
          else
            fail!(:invalid)
          end
        else
          fail!(:invalid)
        end
      end
    end
  end
end
