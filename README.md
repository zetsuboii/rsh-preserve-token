# Reach Preserve Token Package

In Reach every created token must be destroyed at the end. This package provides
a work-around by halting the program.

Import it using
<br>
```js
import { TokenPreserver, preserveToken } from
  "@github.com:Zetsuboii/rpkg-preserve-token#v0.1.8:src/preserveToken.rsh";
``` 
Inherit `TokenPreserver` in one of your participants and call `preserveToken`
at the end of the Reach.App callback.
<br>
For an example implementation check `src/index.rsh`