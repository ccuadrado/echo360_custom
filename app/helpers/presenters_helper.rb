module PresentersHelper
  
  def generate_person_xml(params)
    person = XmlNode.new('person')
    person.put_node('first-name',params['first_name'])
    person.put_node('last-name', params['last_name'])
    person.put_node('email-address', params['email_address'])
    roles = XmlNode.new('roles')
    roles.put_node('role', 'role-presenter')
    person.put_node(roles)
    return person
  end
  
end
