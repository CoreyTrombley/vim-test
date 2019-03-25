let test#javascript#patterns = {
  \ 'test': ['\v^\s*%(it|test)\s*[( ]\s*%("|''|`)(.*)%("|''|`)'],
  \ 'namespace': ['\v^\s*%(describe|suite|context)\s*[( ]\s*%("|''|`)(.*)%("|''|`)'],
\}


function! test#javascript#find_package_json() abort
  let path = fnamemodify('', ':p')
  let pathlevels = len(split(path, '/'))
  while pathlevels >= 1
    let files = split(globpath(path, '*'), '\n')
    let found = index(files, path.'/package.json')
    if found != -1
      return path
    endif
    let splitpath = split(path, '/')
    let chomppath = splitpath[:-2]
    let joinedpath = join(chomppath, '/')
    let path = '/'.joinedpath
    let pathlevels -= 1
  endwhile
  return 0
endfunction


function! test#javascript#has_package(package) abort
  let path = test#javascript#find_package_json()

  if path == 0
    return 0

  for line in readfile(path + '/package.json')
    if line =~ '"'.a:package.'"'
      return 1
    endif
  endfor

  return 0
endfunction

function! TestWhile() abort
  let i = 0
  while i < 10
    let i += 1
    echo i
  endwhile
endfunction
