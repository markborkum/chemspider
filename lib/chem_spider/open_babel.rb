module ChemSpider
  REST(:OpenBabel, :Convert, %w{what from_format to_format}, {
    :selector => 'string', 
    :datatype => String, 
    :first_child => true,
  })
end
