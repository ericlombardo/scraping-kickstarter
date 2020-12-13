require 'nokogiri'  # require libraries/modules here
require 'pry' 
# HTML ELEMENTS NEEDED FOR ITERATION
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image linke: project.css("div.project-thumbail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css(" ul.project-stats li.first.funded strong").text.gsub("%", "").to_i

def create_project_hash
  html = File.read('fixtures/kickstarter.html') # brings in HTML file from folder
  
  kickstarter = Nokogiri::HTML(html)    # NodeSet created using Nokogiri
  
  projects = {} # empty hash created to push all projects into
  
  kickstarter.css("li.project.grid_4").each do |project|  # Iterate through projects
    title = project.css("h2.bbcard_name strong a").text   # set title to title of current project
    
    projects[title.to_sym] = {  # assign title to key and other data to value of the hash
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end

  projects  # returns the hash after all projects are pushed there  
end

create_project_hash # calls the method so that executes