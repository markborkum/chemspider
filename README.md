chemspider
==========

The ChemSpider API (REST interface) wrapped up with a Ruby bow

Examples
--------

```ruby
require 'chemspider'

token = 'YOUR_SECURITY_TOKEN'

inchi = 'InChI=1S/C25H44N4O8/c1-14(2)25(12,37-15(3)30)19(34)29-23(8,9)17(32)27-21(4,5)16(31)26-22(6,7)18(33)28-24(10,11)20(35)36-13/h14H,1-13H3,(H,26,31)(H,27,32)(H,28,33)(H,29,34)'

inchi_key = ChemSpider::InChI::InChIToInChIKey.get!(inchi)

csid = ChemSpider::InChI::InChIKeyToCSID.get!(inchi_key)

extended_compound_info = ChemSpider::MassSpecAPI::GetExtendedCompoundInfo.get!(csid, token)

$stdout.puts(extended_compound_info.inspect)
```
