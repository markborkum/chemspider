module ChemSpider
  REST(:InChI, :CSIDToMol, %w{csid token}, {
    :selector => 'string', 
    :datatype => String, 
    :first_child => true,
  })
  
  REST(:InChI, :InChIKeyToCSID, %w{inchi_key}, {
    :selector => 'string', 
    :datatype => Integer, 
    :first_child => true,
  })
  
  REST(:InChI, :InChIKeyToInChI, %w{inchi_key}, {
    :selector => 'string', 
    :datatype => String, 
    :first_child => true,
  })
  
  REST(:InChI, :InChIKeyToMol, %w{inchi_key}, {
    :selector => 'string', 
    :datatype => String, 
    :first_child => true,
  })
  
  REST(:InChI, :InChIToCSID, %w{inchi}, {
    :selector => 'string', 
    :datatype => Integer, 
    :first_child => true,
  })

  REST(:InChI, :InChIToInChIKey, %{inchi}, {
    :selector => 'string',
    :datatype => String,
    :first_child => true,
  })

  REST(:InChI, :InChIToMol, %w{inchi}, {
    :selector => 'string', 
    :datatype => String, 
    :first_child => true,
  })
  
  REST(:InChI, :InChIToSMILES, %w{inchi}, {
    :selector => 'string', 
    :datatype => String, 
    :first_child => true,
  })
  
  REST(:InChI, :IsValidInChIKey, %w{inchi_key}, {
    :selector => 'boolean', 
    :datatype => TrueClass, 
    :first_child => true,
  })
  
  REST(:InChI, :MolToInChI, %w{mol}, {
    :selector => 'string', 
    :datatype => String, 
    :first_child => true,
  })
  
  REST(:InChI, :MolToInChIKey, %w{mol}, {
    :selector => 'string', 
    :datatype => String, 
    :first_child => true,
  })
  
  REST(:InChI, :ResolveInChIKey, %w{inchi_key out_format}, {
    :selector => 'ArrayOfString string', 
    :datatype => String, 
    :first_child => false,
  })

  REST(:InChI, :SMILESToInChI, %w{smiles}, {
    :selector => 'string', 
    :datatype => String, 
    :first_child => true,
  })
end
