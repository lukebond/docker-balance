docker-balance
---

Dockerisation of the [balance](http://www.inlab.de/balance.html) TCP load balancer tool.

Usage:

```
$ docker run -d -p 8080:8080 lukebond/docker-balance -f 8080 localhost:900{1,3,4}
```

The above will load balance three services on `localhost` that are bound to
ports `9000`, `9001` and `9002`, attaching itself to port `8080`.
