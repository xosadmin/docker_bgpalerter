# docker_bgpalerter
A docker container for BGPAlerter

## How to use it?
- Use following base command to run the docker:
`` docker run -d --name bgpalerter -v /path/to/bgpalerter/storage:/etc/bgpalerter xosadmin/bgpalerter``
- If you want to use customized config.yml, you just only need to place your ``config.yml`` to ``/path/to/bgpalerter/storage``.
