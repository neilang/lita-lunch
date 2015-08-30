module Lita
  module Handlers
    class Lunch < Handler
      REDIS_KEY = 'lunch'

      route(/^lunch (?:places?\s+)?add\s+(.+)$/i, :add_suggestion, command: true, help: { 'lunch add PLACE' => 'Add a lunch place' })
      route(/^lunch (?:places?\s+)?(?:remove|delete)\s+(.+)$/i, :remove_suggestion, command: true, help: { 'lunch remove PLACE' => 'Remove a lunch place' })
      route(/^lunch places?$/i, :list_suggestions, command: true, help: { 'lunch places' => 'List all the known lunch places' })
      route(/^lunch suggest(?:ion)?$/i, :suggest, command: true, help: { 'lunch suggest' => 'Pick somewhere at random' })
      route(/where should (we|i|they) go for lunch/i, :suggest, command: false)

      def suggest(response)
        random = redis.srandmember(REDIS_KEY) || t('.fallback')
        response.reply t('.suggest', place: random)
      end

      def list_suggestions(response)
        values = redis.smembers(REDIS_KEY)
        response.reply values.size > 0 ? values.sort.join("\n") : t('.empty')
      end

      def add_suggestion(response)
        place = response.matches[0][0].strip
        return if place.empty?
        result = redis.sadd(REDIS_KEY, place)
        response.reply result ? t('.added', place: place) : t('.duplicate', place: place)
      end

      def remove_suggestion(response)
        place = response.matches[0][0].strip
        return if place.empty?
        result = redis.srem(REDIS_KEY, place)
        response.reply result ? t('.removed', place: place) : t('.unfound')
      end

      def reset!
        redis.del(REDIS_KEY)
      end
    end

    Lita.register_handler(Lunch)
  end
end
