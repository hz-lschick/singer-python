singer-python
=============

Writes the Singer format from Python

This is a clone of the official [singer-python](https://github.com/singer-io/singer-python) library with loose version requirement.

Use
---

Download and install the library like this:

```bash
git clone http://github.com/singer-io/singer-python
cd singer-python
make install
source .venv/bin/activate
```

Now, from python code within the virtuel env (which was created via
`make install`), you can use the library:

```python
import singer

singer.write_schema('my_table',
	            {'properties':{'id': {'type': 'string', 'key': True}}},
		    ['id'])
singer.write_records('my_table',
                     [{'id': 'b'}, {'id':'d'}])
singer.write_state({'my_table': 'd'})
```


License
-------

Copyright © 2017 Stitch

Distributed under the Apache License Version 2.0
