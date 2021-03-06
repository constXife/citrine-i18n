module Citrine
  module I18n
    # Handler to initialize I18n for the request.
    class Handler
      include HTTP::Handler
      HEADER = "Accept-Language"
      PARAM_NAME = "locale"

      def call(context : HTTP::Server::Context)
        if params_locale = context.params[PARAM_NAME]?
          parser = Citrine::I18n::Parser.new params_locale
          compat = parser.compatible_language_from ::I18n.available_locales if parser

          if compat
            context.locale = compat
          end
        else
          context.locale = ::I18n.default_locale
        end

        call_next(context)
      end
    end
  end
end
