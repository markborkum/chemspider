ChemSpider.rb: ChemSpider wrapped up with a Ruby bow
====================================================

This is a Ruby library for working with the [ChemSpider API](http://www.chemspider.com/AboutServices.aspx).

Features
--------

* 100% coverage of REST operations (support for SOAP is coming soon).
* REST operations support both "GET" and "POST" verbs of the HTTP protocol.
* Provides a clean, object-oriented representation of Web services, operations and their results. 
* Results are automatically translated into Ruby objects. 
* Plays nicely with proxy servers: request URIs can be modified at runtime. 

Examples
--------

```ruby
require 'chemspider'
```
    
### Convert an InChI into an InChIKey

```ruby
inchi = 'InChI=1S/C25H44N4O8/c1-14(2)25(12,37-15(3)30)19(34)29-23(8,9)17(32)27-21(4,5)16(31)26-22(6,7)18(33)28-24(10,11)20(35)36-13/h14H,1-13H3,(H,26,31)(H,27,32)(H,28,33)(H,29,34)'

inchi_key = ChemSpider::InChI::InChIToInChIKey.get!(inchi)
#=> 'HLVCOUOCNKNUFB-UHFFFAOYSA-N'
```

or

```ruby
inchi_key = ChemSpider::InChI::InChIToInChIKey.get!(:inchi => inchi)
#=> 'HLVCOUOCNKNUFB-UHFFFAOYSA-N'
```

### Convert an InChI into an InChIKey (via a proxy server)

```ruby
# accepts the same options as the constructor for the URI class...
uri_options = { :scheme => :https, :host => 'www.mychemspiderproxy.com', :port => 443 }

inchi_key = ChemSpider::InChI::InChIToInChIKey.get!({ :inchi => inchi }, uri_options)
#=> 'HLVCOUOCNKNUFB-UHFFFAOYSA-N' (presumably...)
```
    
### Get extended compound info

```ruby
csid = 4401975
token = 'YOUR_SECURITY_TOKEN'

extended_compound_info = ChemSpider::MassSpecAPI::GetExtendedCompoundInfo.get!(csid, token)
#=> #<ChemSpider::ExtendedCompoundInfo:0x1019d2338 @nominal_mass=528.0, @molecular_weight=528.6389, @molecular_formula="C_{25}H_{44}N_{4}O_{8}", @inchi_key="HLVCOUOCNKNUFB-UHFFFAOYAA", @smiles="O=C(OC)C(NC(=O)C(NC(=O)C(NC(=O)C(NC(=O)C(OC(=O)C)(C)C(C)C)(C)C)(C)C)(C)C)(C)C", @common_name="Methyl N-(2-acetoxy-2,3-dimethylbutanoyl)-2-methylalanyl-2-methylalanyl-2-methylalanyl-2-methylalaninate", @a_log_p=2.18, @monoisotopic_mass=528.315979003906, @average_mass=528.639, @inchi="InChI=1/C25H44N4O8/c1-14(2)25(12,37-15(3)30)19(34)29-23(8,9)17(32)27-21(4,5)16(31)26-22(6,7)18(33)28-24(10,11)20(35)36-13/h14H,1-13H3,(H,26,31)(H,27,32)(H,28,33)(H,29,34)", @csid=4401975, @x_log_p=0.5>
```

or

```ruby
extended_compound_info = ChemSpider::MassSpecAPI::GetExtendedCompoundInfo.get!(:CSID => csid, :token => token)
#=> #<ChemSpider::ExtendedCompoundInfo:0x1019d2338 @nominal_mass=528.0, @molecular_weight=528.6389, @molecular_formula="C_{25}H_{44}N_{4}O_{8}", @inchi_key="HLVCOUOCNKNUFB-UHFFFAOYAA", @smiles="O=C(OC)C(NC(=O)C(NC(=O)C(NC(=O)C(NC(=O)C(OC(=O)C)(C)C(C)C)(C)C)(C)C)(C)C)(C)C", @common_name="Methyl N-(2-acetoxy-2,3-dimethylbutanoyl)-2-methylalanyl-2-methylalanyl-2-methylalanyl-2-methylalaninate", @a_log_p=2.18, @monoisotopic_mass=528.315979003906, @average_mass=528.639, @inchi="InChI=1/C25H44N4O8/c1-14(2)25(12,37-15(3)30)19(34)29-23(8,9)17(32)27-21(4,5)16(31)26-22(6,7)18(33)28-24(10,11)20(35)36-13/h14H,1-13H3,(H,26,31)(H,27,32)(H,28,33)(H,29,34)", @csid=4401975, @x_log_p=0.5>
```

### Get metadata for an operation

```ruby
ChemSpider::MassSpecAPI::GetExtendedCompoundInfo.chem_spider_service_name
#=> 'MassSpecAPI'

ChemSpider::MassSpecAPI::GetExtendedCompoundInfo.chem_spider_operation_name
#=> 'GetExtendedCompoundInfo'

ChemSpider::MassSpecAPI::GetExtendedCompoundInfo.chem_spider_param_names
#=> ['CSID', 'token']
```
    
### Perform a "Simple" Search

```ruby
query = 'Aspirin'
token = 'YOUR_SECURITY_TOKEN'

# the maximum number of attempts...
ASYNC_SEARCH_STATUS_REQUEST_COUNT = 10

# the amount of time to "sleep" between requests...
COOLING_OFF_DURATION_SECONDS = 1.0

# $stderr.puts('[Search] "%s"' % [query])

# send the request, and receive the transaction ID...
rid = ChemSpider::Search::AsyncSimpleSearch.get!(:query => query, :token => token)

result_ready = false

(0..ASYNC_SEARCH_STATUS_REQUEST_COUNT).each do |idx|
  # request the current status for the transaction ID...
  status = ChemSpider::Search::GetAsyncSearchStatus.get!(:rid => rid, :token => token)
  
  # $stderr.puts('[Status %d of %d] %s => %s' % [idx.to_i + 1, ASYNC_SEARCH_STATUS_REQUEST_COUNT, rid, status])
  
  case status
  when 'ResultReady'
    # toggle the flag...
    result_ready = true
    
    # we're ready to go...  
    break
  when 'Failed', 'Suspended', 'TooManyRecords'
    # the search has failed (for some reason)...
    break
  else
    # wait...
    Kernel.sleep(COOLING_OFF_DURATION_SECONDS)
  end
end

if result_ready
  # request the results...
  csids = ChemSpider::Search::GetAsyncSearchResult.get!(:rid => rid, :token => token)
  
  # $stderr.puts('[Results (%d)] %s' % [csids.length, csids.join(', ')])
  
  # do something with the results...
  csids.each do |csid|
    extended_compound_info = ChemSpider::MassSpecAPI::GetExtendedCompoundInfo.get!(csid, token)

    $stdout.puts(extended_compound_info.inspect)
  end
end
```

Dependencies
------------

* [Ruby](http://ruby-lang.org/) (>= 1.8.7)
* [Nokogiri](http://nokogiri.org/) (>= 1.5.0)

Installation
------------

The recommended installation method is via [RubyGems](http://rubygems.org/).
To install the latest official release of ChemSpider.rb, do:

    % [sudo] gem install chemspider-0.0.1.gem

Download
--------

To get a local working copy of the development repository, do:

    % git clone git://github.com/markborkum/chemspider.git

Alternatively, download the latest development version as a tarball as
follows:

    % wget http://github.com/markborkum/chemspider/tarball/master

Authors
-------

* [Mark Borkum](http://github.com/markborkum) - <http://twitter.com/markborkum>
