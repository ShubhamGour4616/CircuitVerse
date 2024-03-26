class ProjectsQuery < GenericQuery
  MAX_RESULTS_PER_PAGE = 10 # Define the constant here with your desired value

  attr_reader :relation

  def initialize(query_params, relation = Project.all)
    super(query_params, relation)
  end

  def most_views
    @relation.order(view: :desc).limit(MAX_RESULTS_PER_PAGE)
  end

  def recent_projects
    @relation.order(created_at: :desc).limit(MAX_RESULTS_PER_PAGE) # Order by creation date
  end
end