module Services
  module User
    class FindUserService
      def self.search(collection, search_term)
        collection.where([sql_template, search_term, *or_conditions(search_term), *and_conditions(search_term)])
      end

      private

      def self.sql_template
        query = <<-SQL
          users.last_name LIKE ?
          OR users.first_name LIKE ?
          OR users.email LIKE ?
          OR users.username LIKE ?
          OR users.first_name LIKE ?
          AND users.last_name LIKE ?
        SQL
      end

      def self.or_conditions(search_term)
        (["%#{search_term}%"] * 3)
      end

      def self.and_conditions(search_term)
        ["%#{search_term.split.first}%", "%#{search_term.split.last}%"]
      end
    end
  end
end
