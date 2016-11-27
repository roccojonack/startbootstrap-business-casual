#! /bin/csh -f

if ($#argv == 0) then
    echo "No args, using 8888 as default port number"
    set port = 8888
else
    echo "will use $argv[1] as port number"
    set port = $argv[1]
endif

python -m SimpleHTTPServer $port
