class Search
  class << self
    def sphinx_search(query, scope=nil, page=nil)
      query = ThinkingSphinx::Query.escape(query)
      return nil if query.empty?
      return nil unless SearchHelper::SCOPES.include?(scope)
      class_name(scope).search(query, page: page)
    end

    private

    def class_name(scope)
      return ThinkingSphinx if scope.nil? || scope == "global"

      if SearchHelper::SCOPES.include?(scope.downcase)
        scope.camelize.constantize
      end
    end
  end
end
