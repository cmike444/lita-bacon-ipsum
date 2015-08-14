module Lita
  module Handlers
    class BaconIpsum < Handler

      ## Bacon Text
      route(/give me bacon text/i, :bacon_ipsum_text, command: true, help: {
          "give me bacon text" => "Gives you: Bacon ipsum dolor amet..."
        })

      def bacon_ipsum_text(response)
        resp = http.get "https://baconipsum.com/api/?type=all-meat&start-with-lorem=1"

        raise 'BaconFail' unless resp.status == 200
        
        bacon = MultiJson.load(resp.body)

        response.reply ">>>#{bacon[0]}"
      rescue  
        response.reply "Sorry, I was unable to retreive bacon for you."
      end

      ## Bacon Image
      route(/give me bacon image (?<width>\d+) by (?<height>\d+)/i, :bacon_ipsum_image, command: true, help: {
          "give me bacon image WIDTH by HEIGHT" => "Gives you a bacon image."
        })

      def bacon_ipsum_image(response)
        match  = response.match_data
        height = match[:height]
        width  = match[:width]

        response.reply "#{width} by #{height} Bacon: http://baconmockup.com/#{width}/#{height}"
      end

    end

    Lita.register_handler(BaconIpsum)
  end
end
