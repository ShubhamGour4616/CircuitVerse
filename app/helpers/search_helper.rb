# frozen_string_literal: true

module SearchHelper
  MAX_RESULTS_PER_PAGE = 5

  def query(resource, query_params)
    case resource
    when "Users"
      # User query
      return UsersQuery.new(query_params).results.page(params[:page]), "/users/circuitverse/search"
    when "Projects"
      # Project query
      projects_query = ProjectsQuery.new(query_params, Project.public_and_not_forked)
  
      case query_params[:search_option]
      when "most_views"
        return projects_query.most_views.page(params[:page]), "/projects/search"
      else
        return projects_query.results.page(params[:page]), "/projects/search"
      end
    end
  end  
end
