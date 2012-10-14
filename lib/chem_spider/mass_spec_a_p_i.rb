module ChemSpider
  class ExtendedCompoundInfo
    ATTRIBUTES = {
      :csid => {
        :selector => 'CSID',
        :datatype => Integer,
        :first_child => true,
      },
      :molecular_formula => {
        :selector => 'MF',
        :datatype => String,
        :first_child => true,
      },
      :smiles => {
        :selector => 'SMILES',
        :datatype => String,
        :first_child => true,
      },
      :inchi => {
        :selector => 'InChI',
        :datatype => String,
        :first_child => true,
      },
      :inchi_key => {
        :selector => 'InChIKey',
        :datatype => String,
        :first_child => true,
      },
      :average_mass => {
        :selector => 'AverageMass',
        :datatype => Float,
        :first_child => true,
      },
      :molecular_weight => {
        :selector => 'MolecularWeight',
        :datatype => Float,
        :first_child => true,
      },
      :monoisotopic_mass => {
        :selector => 'MonoisotopicMass',
        :datatype => Float,
        :first_child => true,
      },
      :nominal_mass => {
        :selector => 'NominalMass',
        :datatype => Float,
        :first_child => true,
      },
      :a_log_p => {
        :selector => 'ALogP',
        :datatype => Float,
        :first_child => true,
      },
      :x_log_p => {
        :selector => 'XLogP',
        :datatype => Float,
        :first_child => true,
      },
      :common_name => {
        :selector => 'CommonName',
        :datatype => String,
        :first_child => true,
      },
    }.freeze
    
    class << self
      def __attributes__
        ATTRIBUTES
      end
    end
    
    attr_reader *ATTRIBUTES.keys
    
    def initialize(attributes = {})
      ATTRIBUTES.keys.each do |attr_name|
        instance_variable_set(:"@#{attr_name}", attributes[attr_name])
      end
    end
  end
  
  REST(:MassSpecAPI, :GetCompressedRecordsSdf, %w{rid token eComp}, {
    :selector => 'base64Binary', 
    :datatype => String, 
    :first_child => true,
  })
  
  REST(:MassSpecAPI, :GetDatabases, %w{}, {
    :selector => 'ArrayOfString string', 
    :datatype => String, 
    :first_child => false,
  })
  
  REST(:MassSpecAPI, :GetExtendedCompoundInfo, %w{CSID token}, {
    :selector => 'ExtendedCompoundInfo', 
    :datatype => ChemSpider::ExtendedCompoundInfo, 
    :first_child => true,
  })
  
  REST(:MassSpecAPI, :GetExtendedCompoundInfoArray, %w{CSIDs token}, {
    :selector => 'ArrayOfExtendedCompoundInfo ExtendedCompoundInfo', 
    :datatype => ChemSpider::ExtendedCompoundInfo, 
    :first_child => false,
  })

  REST(:MassSpecAPI, :GetRecordMol, %w{csid calc3d token}, {
    :selector => 'string', 
    :datatype => String, 
    :first_child => true,
  })
  
  REST(:MassSpecAPI, :GetRecordsSdf, %w{rid token}, {
    :selector => 'string', 
    :datatype => String, 
    :first_child => true,
  })
  
  REST(:MassSpecAPI, :SearchByFormula2, %w{formula}, {
    :selector => 'ArrayOfString string', 
    :datatype => String, 
    :first_child => false,
  })
  
  REST(:MassSpecAPI, :SearchByMass2, %w{mass range}, {
    :selector => 'ArrayOfString string', 
    :datatype => String, 
    :first_child => false,
  })
end
