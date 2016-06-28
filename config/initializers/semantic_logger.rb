SemanticLogger.application = 'PRpal'

if Rails.env.production?
  module PRpal
    module Formatters
      class Logentries < SemanticLogger::Formatters::Json
        def call(log, logger)
          "#{Rails.application.secrets.logentries_token} #{super(log, logger)}"
        end
      end
    end
  end

  Rails.application.config.after_initialize do
    formatter = PRpal::Formatters::Logentries.new
    Rails.application
         .config
         .semantic_logger
         .add_appender(appender: :tcp,
                       server: 'api.logentries.com:20000',
                       ssl: true,
                       formatter: formatter)
  end
end
