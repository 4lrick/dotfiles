# CONFIG
$env.config = {
  show_banner: false
  buffer_editor: "nvim"
  edit_mode: "vi"
  cursor_shape: {emacs: line, vi_insert: line, vi_normal: block}
  keybindings: [
    {
      name: delete_words_backward
      modifier: control
      keycode: char_h
      mode: [emacs, vi_insert]
      event: {edit: BackspaceWord}
    }
    {
      name: delete_words_fordward
      modifier: control
      keycode: delete
      mode: [emacs, vi_insert]
      event: {edit: DeleteWord}
    }
  ]
  abbreviations: {cat: "bat", l: "ls -a"}
}

# ENV
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.SSH_AUTH_SOCK = $"($env.XDG_RUNTIME_DIR)/gcr/ssh"
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
$env.EDITOR = 'nvim'

# ZOXIDE SETUP
zoxide init nushell | save -f ~/.zoxide.nu
source ~/.zoxide.nu

# CARAPACE SETUP
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"
source $"($nu.cache-dir)/carapace.nu"

# OH-MY-POSH SETUP
oh-my-posh init nu --config "~/.config/oh-my-posh/themes/emodipt-extend.omp.json"

# FUNCTIONS
def sf [query: string] {
  sudo updatedb
  sudo locate -i $query | fzf --query $query --bind 'ctrl-r:reload(sudo updatedb; do -i { sudo locate -i {q} })' | wl-copy -o
}

def lsg [...args] {
  if ($args | is-empty) {
    ls
  } else {
    ls ...$args
  } | grid -i -c name
}

def --env yy [...args] {
  let tmp = (mktemp -t "yazi-cwd.XXXXXX")
  ^yazi ...$args --cwd-file $tmp
  let cwd = (open $tmp)
  if $cwd != $env.PWD and ($cwd | path exists) {
    cd $cwd
  }
  rm -fp $tmp
}

# COMMANDS
fastfetch
