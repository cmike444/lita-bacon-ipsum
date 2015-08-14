module Lita
  module Handlers
    class BaconIpsum < Handler
      route(/give me bacon/i, :bacon_ipsum, command: true, help: {
          "give me bacon" => "Bacon ipsum dolor amet..."
        })

      def bacon_ipsum(response)
        resp = http.get "https://baconipsum.com/api/?type=all-meat&start-with-lorem=1"
        
        bacon = MultiJson.load(resp.body)

        if bacon
          response.reply bacon[0]
        else
          response.reply "Sorry, I was unable to retreive bacon for you."
        end
      end

    end

    Lita.register_handler(BaconIpsum)
  end
end
