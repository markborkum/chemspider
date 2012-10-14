module ChemSpider
  class SpectrumInfo
    ATTRIBUTES = {
      :spc_id => {
        :selector => 'spc_id',
        :datatype => Integer,
        :first_child => true,
      },
      :spc_type => {
        :selector => 'spc_type',
        :datatype => String,
        :first_child => true,
      },
      :csid => {
        :selector => 'csid',
        :datatype => Integer,
        :first_child => true,
      },
      :file_name => {
        :selector => 'file_name',
        :datatype => String,
        :first_child => true,
      },
      :comments => {
        :selector => 'comments',
        :datatype => String,
        :first_child => true,
      },
      :original_url => {
        :selector => 'original_url',
        :datatype => URI,
        :first_child => true,
      },
      :submitted_date => {
        :selector => 'submitted_date',
        :datatype => DateTime,
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
  
  REST(:Spectra, :GetAllSpectraInfo, %w{token}, {
    :selector => 'ArrayOfCSSpectrumInfo CSSpectrumInfo', 
    :datatype => ChemSpider::SpectrumInfo, 
    :first_child => false,
  })
  
  REST(:Spectra, :GetCompoundSpectraInfo, %w{csid token}, {
    :selector => 'ArrayOfCSSpectrumInfo CSSpectrumInfo', 
    :datatype => ChemSpider::SpectrumInfo, 
    :first_child => false,
  })
  
  REST(:Spectra, :GetSpectraInfoArray, %w{CSIDs token}, {
    :selector => 'ArrayOfCSSpectrumInfo CSSpectrumInfo', 
    :datatype => ChemSpider::SpectrumInfo, 
    :first_child => false,
  })
  
  REST(:Spectra, :GetSpectrumInfo, %w{spc_id token}, {
    :selector => 'CSSpectrumInfo', 
    :datatype => ChemSpider::SpectrumInfo, 
    :first_child => true,
  })
end
