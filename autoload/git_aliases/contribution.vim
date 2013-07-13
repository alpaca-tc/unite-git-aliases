function! git_aliases#contribution#define()
  return has('ruby') ? { 'Contribution': 'call git_aliases#contribution#git_work_info()'} : {}
endfunction

function! git_aliases#contribution#git_work_info() "{{{
  let since = input('Since: ', alpaca#function#today())
  let until = input('Until: ', alpaca#function#today())
  let author = input('Author: ', get(g:, 'git_aliases#author_name', '')) 
  let result = system("git log --since=".since." --until=".until." --author='".author."' --oneline --shortstat --no-merges | grep 'deletions(-)'")

  redraw
  if empty(result)
    echomsg 'Nothing'
    return 
  endif

  ruby << EOF
  git_result = VIM.evaluate('result')
  result = { :insertions => 0, :deletions => 0 }
  git_result.split(/\n/).each do |line|
    if line.match /^\s*(\d+) files changed, (\d+) insertions\(\+\), (\d+) deletions\(-\)\s*$/
      result[:insertions] += $2.to_i
      result[:deletions] += $3.to_i
    end
  end

  puts "insertions: #{result[:insertions]}"
  puts "deletions : #{result[:deletions]}"
  puts "real      : #{result[:insertions] - result[:deletions]}"
EOF
endfunction"}}}
