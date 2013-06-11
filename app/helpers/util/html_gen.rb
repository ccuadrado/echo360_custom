module HtmlGenerator

  #info - 2d array where each element of the top array is an array that corresponds with a
  # row of the table
  #Table tags not included to allow for header/footer/captions to be done in view
  def create_table(info)
    i=0
    ret = ""
    info.each do |row|
      ret << "<tr class=\"row_num#{i}\">"
      j=0
      row.each do |cell|
        j += 1
        ret << "<td class=\"col_num#{j}\">#{cell}</td>"
      end
      ret << ("</tr>\n")
      i += 1
    end  
    ret
  end

  def content_tag(name, content, options = nil, &block)
    retVal = "<#{name}"
    options.each { |option, value| retVal << " #{option}=\"#{value}\""} unless options.nil?
    retVal << ">#{content}</#{name}>"
  end

  #Takes symbol of the associated object as parameter
  def days_check_box(object)
    return create_table([[label_tag(:monday, "M"), label_tag(:tuesday, "Tu"),
           label_tag(:wednesday, "W"), label_tag(:thursday, "Th"),
           label_tag(:friday, "F"), label_tag(:saturday, "Sa"),
           label_tag(:sunday, "Su")],
          [check_box(object, :monday), check_box(object, :tuesday),
           check_box(object, :wednesday), check_box(object, :thursday),
           check_box(object, :friday), check_box(object, :saturday),
           check_box(object, :sunday)]])  
  end

end
