set fish_prompt_pwd_dir_length 0

set primaryColor "white"
set gitColor "green"
set errorColor "ff6666"

# Git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch "$gitColor"
set __fish_git_prompt_color_dirtystate "$gitColor"
set __fish_git_prompt_color_stagedstate "$gitColor"
set __fish_git_prompt_color_upstream "$gitColor"

# Git Characters
set __fish_git_prompt_char_dirtystate '*'
set __fish_git_prompt_char_stagedstate '⇢'
set __fish_git_prompt_char_upstream_prefix ' '
set __fish_git_prompt_char_upstream_equal ''
set __fish_git_prompt_char_upstream_ahead '⇡'
set __fish_git_prompt_char_upstream_behind '⇣'
set __fish_git_prompt_char_upstream_diverged '⇡⇣'

function _print_in_color
  set -l string $argv[1]
  set -l color  $argv[2]

  set_color $color
  printf $string
  set_color normal
end

function _prompt_color_for_status
  if test $argv[1] -eq 0
    echo "$primaryColor"
  else
    echo "$errorColor"
  end
end

function fish_prompt
  set -l last_status $status

  set workingDir (pwd)
  set baseName (basename $workingDir)

  set longUpper "| $USER@$hostname:$workingDir |"
  set shortUpper "| $USER@$hostname:/.../$baseName |"
  
  if test (echo "$longUpper" | wc -c) -gt $COLUMNS
    _print_in_color $shortUpper $primaryColor
  else
    _print_in_color $longUpper $primaryColor
  end

  __fish_git_prompt " %s"
  
  if test (id -u) != 0
    _print_in_color "\n|\$ " (_prompt_color_for_status $last_status)
  else
    _print_in_color "\n|# " (_prompt_color_for_status $last_status)
  end
end
