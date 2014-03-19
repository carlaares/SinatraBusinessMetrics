This is the source code for the sinatra-template project on github.  
It's the basic structure I use for my Sinatra projects and it make things a bit more organized.  

What's inside?
--------------

* Modular Sinatra app version 1.3.2 using ruby 1.9.3-p125
* minitest for unit-level tests
* rack-test for routes tests
* capybara + minitest for integration tests (no need for rspec)
* yard for documentation
* Rakefile, Gemfile, .rvmrc, .gitignore

Folders Structure
------------------

    app.rb         # require sinatra, vendor'd gems, models/init, routes/init, helpers/init

    helpers/         
      init.rb      # Require each helper file
      helper1.rb   # Related helper methods

    models/          
      init.rb      # Require each model, in controlled order
      user.rb      # model
      picture.rb   # model

    routes/          
      init.rb      # Require each route, in controlled order
      user.rb      # One or more routes related to some feature
      admin.rb     # One or more routes related to administration

    views/
      layout.erb   # Common layout
      index.erb    # Specific view

    test/         
      models       # minitest
      routes       # rack-test
      acceptance  # capybara + minitest

Setup
-----

Install bundler

    gem install bundler

Install the gems

    bundle install --without production staging

View all available rake commands

    rake -T

    rake                  # Run all tests
    rake test:acceptance  # Run acceptance tests
    rake test:models      # Run models tests
    rake test:routes      # Run routes tests
    rake yard             # Generate YARD Documentation

Run the server

    shotgun

Go to [http://127.0.0.1:9393](http://127.0.0.1:9393)


Pre-requisites
--------------

Install statsd

    https://github.com/etsy/statsd


Start statsd
    nohup node statsd/stats.js /home/carla/businessMetrics/mongoStatsdConfig.js &




https://github.com/Shopify/statsd-instrument



<script type="text/javascript">
  var _paq = _paq || [];
  (function(){ 
    var u="http://127.0.0.1:9393/"; 
    _paq.push(['setSiteId', DATABASE_NAME]);
    _paq.push(['trackPageView']);
    _paq.push(['setTrackerUrl', '/_stats']);
    _paq.push(['enableLinkTracking']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0]; g.type='text/javascript'; g.defer=true; g.async=true; g.src=u+'javascript/bm_analytics.js';
    s.parentNode.insertBefore(g,s); 
  })();
</script>
