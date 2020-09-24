# ErlexecRepro

Reproduces erlexec bug: https://github.com/saleyn/erlexec/issues/136

To reproduce run:

    mix deps.get
    mix test
    
The test should hang around number 741 by default
