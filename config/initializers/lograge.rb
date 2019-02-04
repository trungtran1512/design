Rails.application.configure do

  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new
  config.lograge.logger = ActiveSupport::Logger.new(STDOUT)
  config.lograge.custom_options = lambda do |event|
    exceptions = %w(controller action format authenticity_token)
    data = {
      time: event.time.strftime("[%Y-%m-%d]-[%H:%M:%S]-[%z]"),
      ip: event.payload[:ip],
      referer: event.payload[:referer],
      user_agent: event.payload[:user_agent],
      level: 'info',
      user_id: event.payload[:user_id],
      user_name: event.payload[:user_name],
      params: event.payload[:params].except(*exceptions)
    }
    if event.payload[:exception]
      data[:level] = 'error'
      data[:exception] = event.payload[:exception]
      data[:exception_backtrace] = event.payload[:exception_object].backtrace
    end
    data
  end
end
