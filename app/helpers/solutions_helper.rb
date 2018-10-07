module SolutionsHelper
  def setup_solution solution
    solution.file_attachments || solution.file_attachments.build
    solution
  end
end
