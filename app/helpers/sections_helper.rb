module SectionsHelper

  def get_section(section)
    requester = HttpRequester.new('get', Credentials.key, Credentials.secret)
    url = [[URI.parse(Credentials.server + "sections/" + section.essid),nil]]
    response = requester.request(url)[0]
    presenters = response.get_node("presenters")
    3.times { presenters.remove_node(0) }
    presenters_array = Array.new
    presenters.each { |presenter| presenters_array << presenter.get_node("person").get_node("id").value}
    
    #presenters.each do |presenter|
    #  person = presenter.get_node("person")
    #  presenter_string << "   " << person.get_node("last_name").value + ',' + 
    #                             person.get_node("first_name").value
    #end
    
    Section.update(section.id, :section_complete => response.get_node("section_complete").value,
                               :publishing_complete => response.get_node("publishing_complete").value,
                               :do_not_publish => response.get_node("do_not_publish").value,
                               :default_publishers_set => response.get_node("default_publishers_set").value,
                               :presenters => presenters_array)
  end

  def is_true? input
    return input.eql? 'true'
  end

end
