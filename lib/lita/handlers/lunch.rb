module Lita
  module Handlers
    class Lunch < Handler
      REDIS_KEY = 'lunch'

      route(/^lunch places?\s+add\s+(.+)$/i, :add_suggestion, command: true, help: { 'lunch add PLACE' => 'Add a lunch place' })
      route(/^lunch places?\s+(?:remove|delete)\s+(.+)$/i, :remove_suggestion, command: true, help: { 'lunch remove PLACE' => 'Remove a known lunch place' })
      route(/^lunch places?$/i, :list_suggestions, command: true, help: { 'lunch places' => 'List all the known lunch places' })
      route(/^lunch suggest(?:ion)?$/i, :suggest, command: true, help: { 'lunch suggest' => 'Pick somewhere at random' })
      route(/where should (we|i|they) go for lunch/i, :suggest, command: false)

      def suggest(response)
        index = Random.rand(redis.llen(REDIS_KEY).nonzero? || 1)
        random = redis.lindex(REDIS_KEY, index) || t('.fallback')
        response.reply t('.suggest', place: random)
      end

      def list_suggestions(response)
        values = redis.lrange(REDIS_KEY, 0, -1)
        response.reply values.size > 0 ? values.join("\n") : t('.empty')
      end

      def add_suggestion(response)
        place = response.matches[0][0] # TODO: ensure this is not blank
        redis.rpush(REDIS_KEY, place)
        response.reply t('.added', place: place)
      end

      def remove_suggestion(response)
        place = response.matches[0][0]
        result = redis.lrem(REDIS_KEY, 0, place)
        response.reply result.nonzero? ? t('.removed') : t('.unfound')
      end

      def reset!
        redis.del(REDIS_KEY)
      end
    end

    Lita.register_handler(Lunch)
  end
end
