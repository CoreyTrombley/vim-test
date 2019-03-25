let test#javascript#patterns = {
  \ 'test': ['\v^\s*%(it|test)\s*[( ]\s*%("|''|`)(.*)%("|''|`)'],
  \ 'namespace': ['\v^\s*%(describe|suite|context)\s*[( ]\s*%("|''|`)(.*)%("|''|`)'],
\}


function! test#javascript#find_file(name) abort
	let path = fnamemodify(a:name, ':p')
	while path != '/'
		let jsonFiles = split(globpath(path, '*.json'), '\n')
		if get(jsonFiles, 'package.json', 'none') != 'none'
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
