module Lita
  module Handlers
    class BaconIpsum < Handler
      route(/give me bacon/i, :bacon_ipsum, command: true, help: {
          "give me bacon" => "Bacon ipsum dolor amet..."
        })

      def bacon_ipsum(response)
        bacon = http.get "https://baconipsum.com/api/?type=all-meat&start-with-lorem=1"
        
        raise 'RequestFail' unless bacon.status == 200

        response.reply "#{bacon.body[0]}"
      end

    end

    Lita.register_handler(BaconIpsum)
  end
end
