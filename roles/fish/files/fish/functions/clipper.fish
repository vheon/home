switch (uname)
case Linux
    function clipper --description 'wrapper to send data to the clipper port through nc'
      nc localhost -N 8377
    end
case Darwin
    function clipper --description 'wrapper to send data to the clipper port through nc'
      nc localhost 8377
    end
end
