require 'nokogiri'

require 'date'
require 'net/http'
require 'uri'

module ChemSpider
  class << self
    ##
    # Returns the result of calling the specified ChemSpider Web service using the HTTP/1.1 "GET" method. 
    #
    # @example Convert an InChIKey into a ChemSpider ID.
    #   ##
    #   # http://www.chemspider.com/InChI.asmx/InChIKeyToCSID?inchi_key=BSYNRYMUTXBXSQ-UHFFFAOYSA-N
    #   # => <string xmlns="http://www.chemspider.com/">2157</string>
    #   #
    #   ChemSpider.get!(:InChI, :InChIKeyToCSID, { :inchi_key => 'BSYNRYMUTXBXSQ-UHFFFAOYSA-N' }, {}, {
    #     :selector => 'string', 
    #     :datatype => Integer, 
    #     :first_child => true,
    #   })
    #   #=> 2157
    #
    # @example Convert an InChIKey into a ChemSpider ID using a proxy server.
    #   ##
    #   # https://www.example.com:443/chemspider/InChI/InChIKeyToCSID?inchi_key=BSYNRYMUTXBXSQ-UHFFFAOYSA-N
    #   # => <string xmlns="http://www.chemspider.com/">2157</string>
    #   #
    #   ChemSpider.get!(:InChI, :InChIKeyToCSID, { :inchi_key => 'BSYNRYMUTXBXSQ-UHFFFAOYSA-N' }, {
    #     :scheme => :https,
    #     :host => 'www.example.com',
    #     :port => 443,
    #     :path_format => '/chemspider/%s/%s',
    #   }, {
    #     :selector => 'string', 
    #     :datatype => Integer, 
    #     :first_child => true,
    #   })
    #   #=> 2157
    #
    # @param [#to_s] service_name
    # @param [#to_s] operation_name
    # @param [Hash] params (Hash.new)
    # @option uri_options [#to_s] :scheme ('http')
    # @option uri_options [#to_s] :host ('www.chemspider.com')
    # @option uri_options [#to_s] :port (80)
    # @option uri_options [#to_s] :path (nil)
    # @option uri_options [#to_s] :path_format ('/%s.asmx/%s')
    # @option uri_options [#to_s] :query (nil)
    # @option uri_options [#to_s] :fragment (nil)
    # @option options [#to_s] :selector (nil)
    # @option options [Hash, Class, #__attributes__, #new] :datatype (Hash.new)
    # @option options [Boolean] :first_child (false)
    #
    # @return [Object]
    #
    # @see ChemSpider#css
    # @see ChemSpider#uri_for
    #
    def get!(service_name, operation_name, params = {}, uri_options = {}, options = {})
      # construct the URI...
      uri = uri_for(service_name, operation_name, params, uri_options)
      
      # dereference the URI...
      response = Net::HTTP.get_response(uri)
      
      # parse the response...
      doc = Nokogiri::XML(response.body)
      
      # process the result...
      css(doc, options)
    end
    
    ##
    # Returns the result of calling the specified ChemSpider Web service using the HTTP/1.1 "POST" method. 
    #
    # @example Convert an InChIKey into a ChemSpider ID.
    #   ##
    #   # http://www.chemspider.com/InChI.asmx/InChIKeyToCSID?inchi_key=BSYNRYMUTXBXSQ-UHFFFAOYSA-N
    #   # => <string xmlns="http://www.chemspider.com/">2157</string>
    #   #
    #   ChemSpider.post!(:InChI, :InChIKeyToCSID, { :inchi_key => 'BSYNRYMUTXBXSQ-UHFFFAOYSA-N' }, {}, {
    #     :selector => 'string', 
    #     :datatype => Integer, 
    #     :first_child => true,
    #   })
    #   #=> 2157
    #
    # @example Convert an InChIKey into a ChemSpider ID using a proxy server.
    #   ##
    #   # https://www.example.com:443/chemspider/InChI/InChIKeyToCSID?inchi_key=BSYNRYMUTXBXSQ-UHFFFAOYSA-N
    #   # => <string xmlns="http://www.chemspider.com/">2157</string>
    #   #
    #   ChemSpider.post!(:InChI, :InChIKeyToCSID, { :inchi_key => 'BSYNRYMUTXBXSQ-UHFFFAOYSA-N' }, {
    #     :scheme => :https,
    #     :host => 'www.example.com',
    #     :port => 443,
    #     :path_format => '/chemspider/%s/%s',
    #   }, {
    #     :selector => 'string', 
    #     :datatype => Integer, 
    #     :first_child => true,
    #   })
    #   #=> 2157
    #
    # @param [#to_s] service_name
    # @param [#to_s] operation_name
    # @param [Hash] params (Hash.new)
    # @option uri_options [#to_s] :scheme ('http')
    # @option uri_options [#to_s] :host ('www.chemspider.com')
    # @option uri_options [#to_s] :port (80)
    # @option uri_options [#to_s] :path (nil)
    # @option uri_options [#to_s] :path_format ('/%s.asmx/%s')
    # @option uri_options [#to_s] :query (nil)
    # @option uri_options [#to_s] :fragment (nil)
    # @option options [#to_s] :selector (nil)
    # @option options [Hash, Class, #__attributes__, #new] :datatype (Hash.new)
    # @option options [Boolean] :first_child (false)
    #
    # @return [Object]
    #
    # @see ChemSpider#css
    # @see ChemSpider#uri_for
    #
    def post!(service_name, operation_name, params = {}, uri_options = {}, options = {})
      # construct the URI...
      uri = uri_for(service_name, operation_name, nil, uri_options)
      
      # dereference the URI...
      response = Net::HTTP.post_form(uri, params)
      
      # parse the response...
      doc = Nokogiri::XML(response.body)
      
      # process the result...
      css(doc, options)
    end
    
    private
    
    ##
    # Macro to define the Ruby modules and methods for a ChemSpider Web service. 
    #
    # @example 
    #   m = ChemSpider.REST(:InChI, :InChIKeyToCSID, %w{inchi_key}, {
    #     :selector => 'string', 
    #     :datatype => Integer, 
    #     :first_child => true,
    #   })
    #   m.get!('BSYNRYMUTXBXSQ-UHFFFAOYSA-N')
    #   #=> 2157
    #   m.get!(:inchi_key => 'BSYNRYMUTXBXSQ-UHFFFAOYSA-N')
    #   #=> 2157
    #   m.post!('BSYNRYMUTXBXSQ-UHFFFAOYSA-N')
    #   #=> 2157
    #   m.post!(:inchi_key => 'BSYNRYMUTXBXSQ-UHFFFAOYSA-N')
    #   #=> 2157
    #
    # @param [#to_s] service_name
    # @param [#to_s] operation_name
    # @param [Array<String>] param_names
    # @option options [#to_s] :selector (nil)
    # @option options [Hash, Class, #__attributes__, #new] :datatype (Hash.new)
    # @option options [Boolean] :first_child (false)
    #
    # @return [Module]
    #
    # @see ChemSpider#get!
    # @see ChemSpider#post!
    #
    def REST(service_name, operation_name, param_names = [], options = {})
      # find/create the specified module...
      # #=> "ChemSpider::#{service_name}::#{operation_name}"
      mod = [service_name, operation_name].inject(self) { |acc, s|
        begin
          acc.send(:const_get, s.to_sym)
        rescue NameError
          acc.send(:const_set, s.to_sym, Module.new)
        end
      }
      
      # [re]define the methods...
      %w{get! post!}.each do |method_name|
        ##
        # @see ChemSpider#get!
        # @see ChemSpider#post!
        mod.send(:define_method, method_name.to_sym) do |*args|
          # the default `uri_options` argument is an empty Hash
          uri_options = {}

          args_as_hash = nil

          # minimal implementation of the ActiveSupport `Module#extract_options!` method...
          case args.length
          when 2
            uri_options = args.pop if args.last.is_a?(Hash)

            args_as_hash = args.pop if args.last.is_a?(Hash)
          when 1
            args_as_hash = args.pop if args.last.is_a?(Hash)
          else
            uri_options = args.pop if args.last.is_a?(Hash)
          end

          params = nil

          if args_as_hash.nil?
            params = {}

            # treat `args' as an ordered list with a 1-1 correspondence
            # between each element and the list of parameter names...
            param_names.each_with_index do |param_name, idx|
              params[param_name] = args[idx]
            end
          else
            # treat `args' as a "HashWithIndifferentAccess" (in Ruby on Rails parlance)...
            params = param_names.inject({}) { |acc, param_name|
              if args_as_hash.key?(param_name)
                acc[param_name] = args_as_hash[param_name]
              elsif args_as_hash.key?(param_name.to_s)
                acc[param_name] = args_as_hash[param_name.to_s]
              elsif args_as_hash.key?(param_name.to_sym)
                acc[param_name] = args_as_hash[param_name.to_sym]
              end

              acc
            }
          end

          ChemSpider.send(method_name.to_sym, service_name, operation_name, params, uri_options, options)
        end

        # make the method a "module function"...
        mod.send(:module_function, method_name.to_sym)
      end
      
      ##
      # @return [String]
      # @since 0.0.2
      mod.send(:define_method, :chem_spider_service_name) do ||
        service_name.to_s
      end
      
      ##
      # @return [String]
      # @since 0.0.2
      mod.send(:define_method, :chem_spider_operation_name) do ||
        operation_name.to_s
      end
      
      ##
      # @return [Array<String>]
      # @since 0.0.2
      mod.send(:define_method, :chem_spider_param_names) do ||
        param_names.collect(&:to_s)
      end
      
      ##
      # @return [Hash]
      # @since 0.0.2
      mod.send(:define_method, :chem_spider_options) do ||
        options.dup
      end
      
      mod.send(:module_function, :chem_spider_service_name, :chem_spider_operation_name, :chem_spider_param_names, :chem_spider_options)
      
      # done!
      return mod
    end
    
    ##
    # Returns a unary callable that casts the argument to the specified `Class`. 
    #
    # @param [Class] klass
    #
    # @return [#call]
    #
    def cast_for(klass)
      # lazily construct the set of callables...
      @casts ||= {
        TrueClass  => Proc.new { |s| s.downcase == 'true' },
        DateTime   => Proc.new { |s| DateTime.parse(s) },
        Float      => Proc.new { |s| s.to_f },
        Integer    => Proc.new { |s| s.to_i },
        String     => Proc.new { |s| s },
        URI        => Proc.new { |s| URI.parse(s) },
      }.freeze
      
      # raise an exception if no callable is available for the specified `Class`...
      raise "Unsupported cast: #{klass}" unless @casts.key?(klass)
      
      # return the match...
      @casts[klass]
    end
    
    ##
    # Extracts nodes specified by a CSS selector, and casts the result. 
    # 
    # @param [Nokogiri::XML::Node] doc
    # @option options [#to_s] :selector (nil)
    # @option options [Class, Hash, #__attributes__, #new] :datatype (Hash.new)
    # @option options [Boolean] :first_child (false)
    #
    # @return [Object]
    # 
    # @see ChemSpider#cast_for
    #
    def css(doc, options = {})
      # evaluate the CSS selector...
      nodes = doc.css(options[:selector].to_s)
      
      # lazily initialize the datatype to `Hash.new`...
      if !(datatype = (options[:datatype] || {})).nil?
        # the set of attributes...
        attributes = nil
        
        # specifies whether or not we should reify the result (by passing it to a constructor)...
        responds_to_new = nil
        
        # test if the datatype responds to the duck typing method...
        if datatype.respond_to?(:__attributes__)
          # extract the set of attributes from the datatype...
          attributes = datatype.send(:__attributes__)
          
          # test if we should reify the result, i.e., does the datatype have a constructor?
          responds_to_new = datatype.respond_to?(:new)
        elsif datatype.is_a?(Hash)
          # the datatype "is" the set of attributes...
          attributes = datatype
          
          # do not reify the result...
          responds_to_new = false
        end
        
        # test if the set of attributes is valid...
        if attributes.is_a?(Hash)
          # recursively extract each node...
          nodes = nodes.map { |node|
            attributes.inject({}) { |acc, pair|
              acc[pair.first] = css(node, pair.last)
              acc
            }
          }
          
          # reify the extracted results (if needed)...
          nodes = nodes.map { |*args| datatype.send(:new, *args) } if responds_to_new
        else
          # extract the content of each node, and cast the result...
          nodes = nodes.map { |node| node.content.to_s }.map(&cast_for(datatype))
        end
      end
      
      # return either the first result, or all of the results...
      !!options[:first_child] ? nodes.first : nodes
    end
    
    ##
    # Constructs the query string of an URL using the specified key-value pairs.
    #
    # @example Construct a query string with univalued parameters.
    #   ChemSpider.query_for(:foo => 'bar', :alice => 'bob') #=> 'foo=bar&alice=bob'
    #
    # @example Construct a query string with multivalued parameters.
    #   ChemSpider.query_for(:letters => %w{a b c}) #=> 'letters=a&letters=b&letters=c'
    #
    # @param [Array, Hash] pairs
    #
    # @return [#to_s]
    #
    def query_for(pairs)
      return nil if pairs.nil? || pairs.empty?
      
      pairs.map { |pair| 
        # if the "key" is multi-valued, i.e., if the "value" is an Array...
        if pair.last.is_a?(Array)
          # recur...
          query_for(pair.last.map { |value| [pair.first, value] })
        else
          # ensure that the components are encoded...
          pair.map { |s| URI.encode(s.to_s) }.join('=')
        end
      }.join('&')
    end
    
    ##
    # Constructs the URI for a request to a ChemSpider Web service. 
    #
    # @example Construct a URI.
    #   ChemSpider.uri_for(:InChI, :InChIKeyToCSID, :inchi_key => 'BSYNRYMUTXBXSQ-UHFFFAOYSA-N')
    #   #=> #<URI::HTTP:0x1003d2308 URL:http://www.chemspider.com/InChI.asmx/InChIKeyToCSID?inchi_key=BSYNRYMUTXBXSQ-UHFFFAOYSA-N>
    #
    # @example Construct a URI for a proxy server.
    #   ChemSpider.uri_for(:InChI, :InChIKeyToCSID, { :inchi_key => 'BSYNRYMUTXBXSQ-UHFFFAOYSA-N' }, {
    #     :scheme => :https,
    #     :host => 'www.example.com',
    #     :port => 443,
    #     :path_format => '/chemspider/%s/%s',
    #   })
    #   #=> #<URI::HTTP:0x101990e88 URL:http://www.example.com:443/chemspider/InChI/InChIKeyToCSID?inchi_key=BSYNRYMUTXBXSQ-UHFFFAOYSA-N>
    #
    # @param [#to_s] service_name
    # @param [#to_s] operation_name
    # @param [Hash] params (Hash.new)
    # @option options [#to_s] :scheme ('http')
    # @option options [#to_s] :host ('www.chemspider.com')
    # @option options [#to_s] :port (80)
    # @option options [#to_s] :path (nil)
    # @option options [#to_s] :path_format ('/%s.asmx/%s')
    # @option options [#to_s] :query (nil)
    # @option options [#to_s] :fragment (nil)
    #
    # @return [URI]
    #
    # @see ChemSpider#query_for
    #
    def uri_for(service_name, operation_name, params = {}, options = {})
      # initialize the format string for the base URI "scheme://host:port"...
      format = '%s://%s:%s'
      format_args = [
        options[:scheme] || :http,
        options[:host] || 'www.chemspider.com',
        options[:port] || 80,
      ]
      
      if path = options[:path]
        # use the custom path (if specified)...
        format += '%s'
        format_args << path
      elsif path_format = (options[:path_format] || '/%s.asmx/%s')
        # otherwise, format the path...
        format += path_format
        format_args << service_name
        format_args << operation_name
      end
      
      # concatinate the constructed and specified query strings (`params` and `options[:query]`)...
      if !(query = [options[:query], query_for(params)].compact.map(&:to_s).map(&:strip).reject(&:empty?)).empty?
        format += '?%s'
        format_args << query.join('&')
      end

      if fragment = options[:fragment]
        # use the custom fragment (if specified...)
        format += '#%s'
        format_args << fragment
      end

      # evaluate the format string for the given arguments, and parse the result...
      URI.parse(format % format_args)
    end
  end
end

require 'chem_spider/version'

require 'chem_spider/services/in_ch_i'
require 'chem_spider/services/mass_spec_a_p_i'
require 'chem_spider/services/open_babel'
require 'chem_spider/services/search'
require 'chem_spider/services/spectra'
