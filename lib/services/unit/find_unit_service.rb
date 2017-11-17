module Services
  module Unit
    class FindUnitService
      def self.search(collection, search_term)
        collection.where([sql_template, search_term, *or_conditions(search_term)])
      end

      private

      def self.sql_template
        query = <<-SQL
          units.name LIKE ?
          OR units.city LIKE ?
          OR units.state LIKE ?
        SQL
      end

      def self.or_conditions(search_term)
        (["%#{search_term}%"] * 2)
      end
    end
  end
end
