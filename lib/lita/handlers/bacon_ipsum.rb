module Lita
  module Handlers
    class BaconIpsum < Handler

      ## Bacon Text
      route(/give me bacon (text)?/i, :bacon_ipsum_text, command: true, help: {
          "give me bacon" => "Bacon ipsum dolor amet... Alternate: `give me bacon text`"
        })

      def bacon_ipsum_text(response)
        resp = http.get "https://baconipsum.com/api/?type=all-meat&start-with-lorem=1"

        raise 'BaconFail' unless resp.status == 200
        
        bacon = MultiJson.load(resp.body)

        response.reply ">>>#{bacon[0]}"
      rescue  
        response.reply "Sorry, I was unable to retreive bacon for you."
      end

      ## Bacon Images
      route(/give me bacon (image)? ((?<width>\d+) by (?<height>\d+))?/i, :bacon_ipsum_image, command: true, help: {
          "give me bacon image WIDTH by HEIGHT" => "Gives bacon image based on WIDTH and HEIGHT"
        })

      def bacon_ipsum_image(response)
        height = response.match_data[:height] ||= 200
        width  = response.match_data[:width] ||= 600

        response.reply "<http://baconmockup.com/#{width}/#{height}|#{width} by #{height} Bacon>"
      rescue  
        response.reply "Sorry, I was unable to retreive bacon for you."
      end

    end

    Lita.register_handler(BaconIpsum)
  end
end
