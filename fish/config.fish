function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive # Commands to run in interactive sessions can go here

    # No greeting
    set fish_greeting

    # Use starship
    starship init fish | source
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    alias ls 'eza --icons'
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias q 'qs -c ii'

    zoxide init fish | source
    abbr cd z
    abbr c z

    source /usr/share/doc/find-the-command/ftc.fish

end

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"

# pnpm
set -gx PNPM_HOME "/home/bartoszg/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
