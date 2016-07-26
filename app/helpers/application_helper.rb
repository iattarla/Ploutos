module ApplicationHelper

def ap(path)
  "active" if current_page?(path)
end


def cp(path)
  "current" if current_page?(path)
end

end
