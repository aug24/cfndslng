# CFNDSL Wrapper to Cloudformation Demo

Requires:

  * ruby
  * [cfndsl](https://github.com/cfndsl/cfndsl)

Optional:

  * [json2yaml](https://www.npmjs.com/package/json2yaml) if you like yaml output

# Implementation

```
#!/usr/bin/env ruby
require_relative 'lib/cfndslng.rb'

CloudFormation {
  <templates>
}
```

# Build

see bin/build and bin/build_yaml
