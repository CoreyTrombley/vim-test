let test#javascript#patterns = {
  \ 'test': ['\v^\s*%(it|test)\s*[( ]\s*%("|''|`)(.*)%("|''|`)'],
  \ 'namespace': ['\v^\s*%(describe|suite|context)\s*[( ]\s*%("|''|`)(.*)%("|''|`)'],
\}


function! test#javascript#find_package_json() abort
  let path = fnamemodify('', ':p')
  while path != '/'
    echo path
    if get(split(globpath(path, '*.json'), '\n'), 'package.json', 'none') != 'none'
      return path
    else
      let splitpath = split(path, '/')
      let chomppath = splitpath[:-2]
      let path = '/' + join(chomppath, '/')
    endif
  endwhile
  return 1
endfunction


function! test#javascript#has_package(package) abort
  let path = test#javascript#find_package_json()

  for line in readfile(path + '/package.json')
    if line =~ '"'.a:package.'"'
      return 1
    endif
  endfor

  return 0
endfunction
