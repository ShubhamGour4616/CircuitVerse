# frozen_string_literal: true

class GenericQuery
  attr_reader :query_params, :relation

  def initialize(query_params, relation)
    @query_params = query_params
    @relation = relation
    @search = Search.new(query_params, relation)
  end

  def results
    @search.call
  end
end

