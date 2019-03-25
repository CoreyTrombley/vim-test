let test#javascript#patterns = {
  \ 'test': ['\v^\s*%(it|test)\s*[( ]\s*%("|''|`)(.*)%("|''|`)'],
  \ 'namespace': ['\v^\s*%(describe|suite|context)\s*[( ]\s*%("|''|`)(.*)%("|''|`)'],
\}


function! test#javascript#find_file() abort
	let path = fnamemodify(%, ':p')
	while path !== '/'
		let jsonFiles = split(globpath(x, '*.json'), '\n')
		if get(jsonFiles, 'package.json')
			return path
		else
			set path = join(split(path, '/')[:-1])
		endif
	endwhile
	return path
endfunction


function! test#javascript#has_package(package) abort
  let path = test#javascript#find_file()

  for line in readfile(path + '/package.json')
    if line =~ '"'.a:package.'"'
      return 1
    endif
  endfor

  return 0
endfunction
