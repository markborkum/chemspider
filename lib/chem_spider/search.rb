module ChemSpider
  class CompoundInfo
    ATTRIBUTES = {
      :csid => {
        :selector => 'CSID',
        :datatype => Integer,
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
      :smiles => {
        :selector => 'SMILES',
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
  
  class ExtRef
    ATTRIBUTES = {
      :csid => {
        :selector => 'CSID',
        :datatype => Integer,
        :first_child => true,
      },
      :ds_name => {
        :selector => 'ds_name',
        :datatype => String,
        :first_child => true,
      },
      :ds_url => {
        :selector => 'ds_url',
        :datatype => URI,
        :first_child => true,
      },
      :ext_id => {
        :selector => 'ext_id',
        :datatype => String,
        :first_child => true,
      },
      :ext_url => {
        :selector => 'ext_url',
        :datatype => URI,
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
  
  REST(:Search, :AsyncSimpleSearch, %w{query token}, {
    :selector => 'string', 
    :datatype => String, 
    :first_child => true,
  })
  
  REST(:Search, :CSID2ExtRefs, %w{CSID datasources token}, {
    :selector => 'ArrayOfExtRef ExtRef', 
    :datatype => ChemSpider::ExtRef, 
    :first_child => false,
  })
  
  REST(:Search, :GetAsyncSearchResult, %w{rid token}, {
    :selector => 'ArrayOfInt int', 
    :datatype => Integer, 
    :first_child => false,
  })
  
  REST(:Search, :GetAsyncSearchResultPart, %w{rid token start count}, {
    :selector => 'ArrayOfInt int', 
    :datatype => Integer, 
    :first_child => false,
  })
  
  REST(:Search, :GetAsyncSearchStatus, %w{rid token}, {
    :selector => 'ERequestStatus', 
    :datatype => String, 
    :first_child => true,
  })
  
  REST(:Search, :GetCompoundInfo, %w{CSID token}, {
    :selector => 'CompoundInfo', 
    :datatype => ChemSpider::CompoundInfo, 
    :first_child => true,
  })
  
  REST(:Search, :GetCompoundThumbnail, %w{id token}, {
    :selector => 'base64Binary', 
    :datatype => String, 
    :first_child => true,
  })
  
  REST(:Search, :GetDataSliceCompounds, %w{name token}, {
    :selector => 'ArrayOfInt int', 
    :datatype => Integer, 
    :first_child => false,
  })
  
  REST(:Search, :Mol2CSID, %w{mol options token}, {
    :selector => 'ArrayOfInt int', 
    :datatype => Integer, 
    :first_child => false,
  })
  
  REST(:Search, :MolAndDS2CSID, %w{mol options datasources token}, {
    :selector => 'ArrayOfInt int', 
    :datatype => Integer, 
    :first_child => false,
  })
  
  REST(:Search, :SimpleSearch, %w{query token}, {
    :selector => 'ArrayOfInt int', 
    :datatype => Integer, 
    :first_child => false,
  })
end
