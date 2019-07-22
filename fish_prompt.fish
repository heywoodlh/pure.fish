set fish_prompt_pwd_dir_length 0

# Git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch 3D8BC2
set __fish_git_prompt_color_dirtystate FCBC47
set __fish_git_prompt_color_stagedstate black
set __fish_git_prompt_color_upstream cyan

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
    echo black
  else
    echo red
  end
end

function fish_prompt
  set -l last_status $status

  _print_in_color "❯$USER@$hostname:"(prompt_pwd) black

  __fish_git_prompt " %s"
  if test [(id -u) != 0]
    _print_in_color "\n\$ " (_prompt_color_for_status $last_status)
  else
    _print_in_color "\n# " (_prompt_color_for_status $last_status)
  end
end
