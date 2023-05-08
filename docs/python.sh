# Python snippets

### 1) Make python script an executable

We need to add shebang in the first like of the file:
```python
#!/usr/bin/env python
``` 

Then we can enable execution of the file as:
```bash
chmod +x script.py
```

And then we can run the script like:
```bash
./script.py
```
instead of 
```bash
python script.py
```
