# docker-http-simple-proxy
*Based on the image by [@picoded](https://github.com/picoded/dockerfiles).*

A simple docker image to proxy a HTTP request to another server.

## Inputs
### Environment Variables
| Name                 | Description                                       | Default |
| -------------------- | ------------------------------------------------- | ------- |
| `FORWARD_HOST`       | The host to forward the request to.               | webhost |
| `FORWARD_PORT`       | The port to forward the request to.               | 80      |
| `FORWARD_PROT`       | The protocol to use when forwarding the request.  | http    |
| `PROXY_READ_TIMEOUT` | The Nginx proxy read timeout.                     | 600     |
| `MAX_BODY_SIZE`      | The client max body size.                         | 100M    |
| `MAX_BUFFER_SIZE`    | The client buffer size, before writing a tmp file | 10M     |
| `DNS`                | The DNS server to use                             |         |
| `DNS_VALID_TIMEOUT`  | The DNS validity timeframe                        | 10s     |


## Usage
![Stable](https://img.shields.io/github/v/release/emilymclean/docker-http-simple-proxy?label=Stable)
![Preview](https://img.shields.io/github/v/release/emilymclean/docker-http-simple-proxy?label=Preview&include_prereleases)


```
docker run \
    -e FORWARD_HOST='' \ 
    -e FORWARD_PORT='' \
    -e FORWARD_PROT='' \
    -e PROXY_READ_TIMEOUT='' \
    -e MAX_BODY_SIZE='' \
    -e MAX_BUFFER_SIZE='' \
    -e DNS='' \
    -e DNS_VALID_TIMEOUT='' \
    ghcr.io/emilymclean/docker-http-simple-proxy:<version>
```