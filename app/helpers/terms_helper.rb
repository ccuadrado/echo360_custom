module TermsHelper

  #Gets terms from the table
  def get_terms
    
    terms = Term.all
    ret_val = Array.new

    requester = HttpRequester.new("get", Credentials.key, Credentials.secret)
    terms.each do |term|
      ret_val << [term.name,
                  term.start_date.localtime.strftime("%Y-%m-%d"),
                  term.end_date.localtime.strftime("%Y-%m-%d")
                 ]
    end
    
    return ret_val
  end
end
